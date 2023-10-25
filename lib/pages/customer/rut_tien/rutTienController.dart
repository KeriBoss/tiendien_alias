import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/dialog/dialog.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/admin/home/homeController.dart';
import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:tiendien_alias/provider/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class RutTienController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final oCcy = NumberFormat("#,##0", "en_US");
  RxInt price = RxInt(0);
  final xuController = TextEditingController();
  MainController mainController = Get.put(MainController());
  HomeController homeController = Get.put(HomeController());
  Rxn<UserModel> currentUser = Rxn();

  DatabaseProvider databaseProvider = DatabaseProvider();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    currentUser.value = await UserModelProvider().getCurrentUser();
  }

  void updatePrice() {
    int xu = int.parse(xuController.text);
    price.value = xu;
  }

  rutTien() async {
    FocusManager.instance.primaryFocus!.unfocus();
    int xu = int.parse(xuController.text);
    num currentMoney = currentUser.value!.money;
    mainController.showIndicadorDialog();
    if (currentMoney >= xu) {
      final docRutTien = FirebaseFirestore.instance.collection('napTien').doc();
      String id = docRutTien.id;
      DateTime now = DateTime.now();

      Random random = Random();
      int randomNumber = random.nextInt(10000) + 10000;
      GiaoDichModel napTienModel = GiaoDichModel(
          id,
          randomNumber.toString(),
          currentUser.value!.id,
          currentUser.value!.name,
          '',
          now,
          "",
          (price.value).toString(),
          LoaiGiaoDich.rutTien,
          "Chờ xử lý",
          "");
      await docRutTien.set(napTienModel.toJson()).then((value) => Get.close(1));

      currentUser.value!.money = currentMoney - xu;

      await databaseProvider.editModel(
          collection: 'users',
          id: currentUser.value!.id,
          toJsonModel: currentUser.value!.toJson());

      if (DateTime.now().day >= 12) {
        showCofirmDialog("Thông báo",
            "Đã gửi yêu cầu rút ${oCcy.format(xu)} đ , yêu cầu sẽ được xử lý trong vòng 24h");
      } else {
        showCofirmDialog("Thông báo", "Rút thành công");
      }
    } else {
      Get.back();
      Get.snackbar("Thông báo", "Số tiền trong tài khoản bạn không đủ");
    }
  }
}
