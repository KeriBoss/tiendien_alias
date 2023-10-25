import 'package:tiendien_alias/Sevice/AuthService.dart';
import 'package:tiendien_alias/Sevice/RealTimeDatabaseService.dart';
import 'package:tiendien_alias/models/nhanvien.dart';
import 'package:tiendien_alias/models/user.dart';
import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThemNhanVienController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  AuthService authService = AuthService();
  RealTimeDatabaseService databaseService = RealTimeDatabaseService();
  final MainController _mainController = Get.put(MainController());
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
  }

  void signUpValidate(BuildContext context) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('HH:mm:ss dd-MM-yyyy').format(now);
      _mainController.showIndicadorDialog();
      UserCredential userCredential = await authService.fireAuth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      NhanVien userModel = NhanVien(
          userCredential.user!.uid,
          userNameController.text,
          emailController.text,
          passwordController.text,
          0,
          0,
          addressController.text,
          phoneController.text,
          "",
          false,
          1,
          "",
          "",
          "0",
          "Đang hoạt động",
          0,
          formattedDate);

      print(userCredential.user!.uid);
      await databaseService.setUserbyID(userModel);

      Get.back();
      _mainController.alertDialog('Thêm nhân viên thành công', context,
          exit: () => Get.back());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Email này đã được đăng kí .');
        Get.offNamed("/signup");
        _mainController.alertDialog('Email này đã được đăng kí .', context);
      }
    } catch (e) {
      print(e);
    }
  }
}
