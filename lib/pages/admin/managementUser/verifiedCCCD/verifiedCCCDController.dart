import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifiedCCCDController extends GetxController {
  var gender = "".obs;
  UserModel userModel = Get.arguments;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    gender.value = userModel.gender;
  }

  Future<void> xacThuc() async {
    DiaLog.showIndicatorDialog();
    userModel.verifiedCCCD = true;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.id)
        .update(userModel.toJson())
        .then((value) {
      Get.close(2);
      Get.snackbar("Thông báo", "Xác thực thành công", colorText: Colors.green);
    });
  }

  Future<void> blockAccount() async {
    DiaLog.showIndicatorDialog();
    userModel.isBlock = true;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.id)
        .update(userModel.toJson())
        .then((value) {
      Get.close(2);
      Get.snackbar("Thông báo", "Khóa tài khoản thành công",
          colorText: Colors.red);
    });
  }

  Future<void> unBlockAccount() async {
    DiaLog.showIndicatorDialog();
    userModel.isBlock = false;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.id)
        .update(userModel.toJson())
        .then((value) {
      Get.close(2);
      Get.snackbar("Thông báo", "Mở khoá tài khoản thành công",
          colorText: Colors.green);
    });
  }
}
