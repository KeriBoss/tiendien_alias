import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuenMatKhauLogic extends GetxController {
  final formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final emailController = TextEditingController();

  Future<void> forgotPassword() async {
    if(formKey.currentState!.validate()) {
      try {
        await firebaseAuth.sendPasswordResetEmail(email: emailController.text).then((value) {
          Get.defaultDialog(
              title: "Thông báo",
              middleText: "Link đổi mật khẩu đã gửi đến email của bạn, Vui lòng vào email kiểm tra",
              backgroundColor: Colors.green,
              titleStyle: const TextStyle(color: Colors.blue),
              middleTextStyle: const TextStyle(color: Colors.white),
              radius: 30,
              barrierDismissible: false
          );
          Future.delayed(const Duration(seconds: 5), () {
            Get.close(1);
          });
        });
      } on FirebaseAuthException catch (e) {
        print(e.toString());
        if(e.code == 'user-not-found') {
          Get.snackbar("Thông báo", "Email chưa đăng ký",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white
          );
        }
      }
    }
  }

}