import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/localStorageService.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  Rxn<UserModel> currentUser = Rxn();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await onChangeUser();
  }

  Future<void> logOut() async {
    DiaLog.showDiaLogYN(
        title: "Thông báo",
        content: "Bạn có muốn thoát không!!!",
        accept: () async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'token': ""});
          await FirebaseAuth.instance.signOut();
          // remove data phone local
          LocalStorageService.setValue("phone", '');
          Get.offAllNamed("/welcome");
        });
  }

  onChangeUser() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) async {
      currentUser.value = await UserModelProvider().getCurrentUser();
    });
  }

  int randomNumber() {
    Random random = Random();
    // Generate a random number within the specified range
    int firstPart = random.nextInt(900000) + 100000;
    int secondPart = random.nextInt(900000) + 100000;
    // Concatenate the two parts to create a 12-digit number
    int random12DigitNumber = int.parse('$firstPart$secondPart');

    return random12DigitNumber;
  }
}
