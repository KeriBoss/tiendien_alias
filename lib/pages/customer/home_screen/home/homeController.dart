import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/MessagingService.dart';
import 'package:tiendien_alias/dialog/dialog.dart';

import 'package:tiendien_alias/models/dichVuMain.dart';
import 'package:tiendien_alias/models/dichVuSub.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/admin/home/homeController.dart';

import 'package:tiendien_alias/provider/dichVuProvider.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../home_screen_controller.dart';

class CustomerHomeViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  UserModelProvider userModelProvider = UserModelProvider();
  Rxn<UserModel> currentUser = Rxn();
  DichVuProvider dichVuProvider = DichVuProvider();
  HomeController homeController = Get.put(HomeController());
  final CustomerHomeController _homeScreenController =
      Get.put(CustomerHomeController());
  RxList<DichVuSub> listDichVuSub = RxList();
  RxList<DichVuMain> listDichVuMain = RxList();
  var currentIndex = 0.obs;
  RxBool isOpenSnackBar = false.obs;
  AnimationController? animationController;
  MessagingService messagingService = MessagingService();

  @override
  void onInit() async {
    if (FirebaseAuth.instance.currentUser != null) {
      animationController = AnimationController(
          duration: const Duration(milliseconds: 1000), vsync: this);
      currentUser.value = await userModelProvider.getCurrentUser();
      print(currentUser.value!.toJson());
      // if (currentUser.value!.verified == false) {
      //   showCofirmDialog("Thông báo", " Vui lòng xác thực tài khoản",
      //       exit: () => Get.toNamed("phone_verified",
      //           arguments: {"phone": currentUser.value!.phone}));
      // }
      messagingService.requestPermission();
      messagingService.listenFCM();
      messagingService.loadFCM();
      await onChangeValue();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((event) async {
        currentUser.value = await userModelProvider.getCurrentUser();
      });
    }

    super.onInit();
  }

  Future<bool> onWillPop() async {
    if (_homeScreenController.counter.value == 0) {
      return (await Get.dialog(
            AlertDialog(
              title: const Text(
                'Thông báo',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              content: const Text('Bạn muốn thoát ứng dụng?'),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.close(1);
                        SystemNavigator.pop();
                      },
                      child: const Text('Thoát '),
                    ),
                  ],
                )
              ],
            ),
          )) ??
          false;
    }
    _homeScreenController.isSelectedTask.value = false;
    _homeScreenController.isSelectedChat.value = false;
    _homeScreenController.isSelectedHome.value = true;
    _homeScreenController.isSelectedDots.value = false;
    _homeScreenController.counter.value = 0;
    return false;
  }

  Future<bool> getBankCustomer() async {
    bool flag = false;
    await FirebaseFirestore.instance
        .collection('customerBank')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        print(value['nameBank']);
        flag = true;
      }
    });
    return flag;
  }

  onChangeValue() async {
    await FirebaseFirestore.instance
        .collection('customerBank')
        .snapshots()
        .listen((event) {
      getBankCustomer();
    });
  }
}
