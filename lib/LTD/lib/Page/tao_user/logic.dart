import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiendien_alias/LTD/lib/DiaLog.dart';
import 'package:tiendien_alias/LTD/lib/Firebase/Firebase_Auth.dart';
import 'package:tiendien_alias/LTD/lib/Models/Users.dart';

class TaoUserLogic extends GetxController {
  final FirebaseAuthen _firebaseAuthen = FirebaseAuthen();
  String qrCodeData = "";
  RxBool isHide = RxBool(true);
  RxBool isHideConfirm = RxBool(true);
  var username = TextEditingController();
  var email = TextEditingController();
  var phoneNumber = TextEditingController();
  var address = TextEditingController();
  var password = TextEditingController();
  var cfPassword = TextEditingController();
  RxString selectedSpecialty = "".obs;
  GlobalKey<FormState> keys = GlobalKey<FormState>();

  void signUpGa() async {
    final prefs = await SharedPreferences.getInstance();
    final String? emailString = prefs.getString('email');
    final String? passString = prefs.getString('password');
    try {
      DiaLog.showIndicatorDialog();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) async {
        if (FirebaseAuth.instance.currentUser != null) {
          User? user = FirebaseAuth.instance.currentUser;
          UserModelLTD userModel = UserModelLTD(
              user!.uid,
              username.text.trim(),
              email.text.trim(),
              address.text.trim(),
              "",
              "",
              phoneNumber.text.trim(),
              2,
              DateTime.now(),
              "");
          FirebaseFirestore.instance
              .collection('usersltd')
              .doc(userModel.id)
              .get()
              .then((value) async {
            if (!value.exists) {
              await FirebaseFirestore.instance
                  .collection('usersltd')
                  .doc(userModel.id)
                  .set(userModel.toJson())
                  .then((value) {});
            }
          }).whenComplete(() {
            FirebaseAuth.instance.signOut();
            FirebaseAuth.instance.signInWithEmailAndPassword(
                email: emailString!, password: passString!);
            Get.close(2);
            Get.snackbar("Thông báo", "Tạo tài khoản thành công",
                backgroundColor: Colors.green, colorText: Colors.white);
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.close(1);
        Get.snackbar("Thông báo", "Email đã tồn tại trên hệ thống",
            backgroundColor: Colors.red);
      }
    }
  }
  // void signUpMen() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? emailString = prefs.getString('email');
  //   final String? passString = prefs.getString('password');
  //   try {
  //     DiaLog.showIndicatorDialog();
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim())
  //         .then((value) async {
  //       if (FirebaseAuth.instance.currentUser != null) {
  //         User? user = FirebaseAuth.instance.currentUser;
  //         UserModel userModel = UserModel(
  //             user!.uid,
  //             username.text.trim(),
  //             email.text.trim(),
  //             address.text.trim(),
  //             "",
  //             "",
  //             phoneNumber.text.trim(),
  //             3, DateTime.now(),"");
  //         FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(userModel.id)
  //             .get()
  //             .then((value) async {
  //           if (!value.exists) {
  //             await FirebaseFirestore.instance
  //                 .collection('users')
  //                 .doc(userModel.id)
  //                 .set(userModel.toJson())
  //                 .then((value) {});
  //           }
  //
  //         }).whenComplete(() {
  //           FirebaseAuth.instance.signOut();
  //           FirebaseAuth.instance.signInWithEmailAndPassword(email: emailString!, password: passString!);
  //           Get.close(2);
  //           Get.snackbar("Thông báo", "Tạo tài khoản thành công",
  //               backgroundColor: Colors.green,
  //               colorText: Colors.white
  //           );
  //         });
  //       }
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'email-already-in-use') {
  //       Get.close(1);
  //       Get.snackbar("Thông báo", "Email đã tồn tại trên hệ thống", backgroundColor: Colors.red);
  //     }
  //   }
  // }
  // void signUpFull() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? emailString = prefs.getString('email');
  //   final String? passString = prefs.getString('password');
  //   try {
  //     DiaLog.showIndicatorDialog();
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim())
  //         .then((value) async {
  //       if (FirebaseAuth.instance.currentUser != null) {
  //         User? user = FirebaseAuth.instance.currentUser;
  //         UserModel userModel = UserModel(
  //             user!.uid,
  //             username.text.trim(),
  //             email.text.trim(),
  //             address.text.trim(),
  //             "",
  //             "",
  //             phoneNumber.text.trim(),
  //             4, DateTime.now(),"");
  //         FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(userModel.id)
  //             .get()
  //             .then((value) async {
  //           if (!value.exists) {
  //             await FirebaseFirestore.instance
  //                 .collection('users')
  //                 .doc(userModel.id)
  //                 .set(userModel.toJson())
  //                 .then((value) {});
  //           }
  //
  //         }).whenComplete(() {
  //           FirebaseAuth.instance.signOut();
  //           FirebaseAuth.instance.signInWithEmailAndPassword(email: emailString!, password: passString!);
  //           Get.close(2);
  //           Get.snackbar("Thông báo", "Tạo tài khoản thành công",
  //               backgroundColor: Colors.green,
  //               colorText: Colors.white
  //           );
  //         });
  //       }
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'email-already-in-use') {
  //       Get.close(1);
  //       Get.snackbar("Thông báo", "Email đã tồn tại trên hệ thống", backgroundColor: Colors.red);
  //     }
  //   }
  // }
}
