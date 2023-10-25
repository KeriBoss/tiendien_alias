import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/localStorageService.dart';
import 'package:tiendien_alias/models/customer.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/resgister/verifiedPhone/verifiedPhonePage.dart';
import 'package:tiendien_alias/provider/sms_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKeyPass = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final maskFormatter = MaskTextInputFormatter(
      mask: '### ### ###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  RxBool isVisibility = RxBool(false);

  Future<void> signIn() async {
    DiaLog.showIndicatorDialog();
    String phone = "0${maskFormatter.getUnmaskedText()}";
    String password = passwordController.text.trim();
    await FirebaseFirestore.instance
        .collection('users')
        .where('phone', isEqualTo: phone)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        UserModel user = UserModel.fromJson(value.docs.first.data());
        String email = user.email;

        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          String? fcmToken;
          if (!kIsWeb) {
            fcmToken = await FirebaseMessaging.instance.getToken();
          }
          // set phone for face id
          LocalStorageService.setValue("phone", phone);
          if (!kIsWeb) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              'password': password,
              'token': fcmToken,
            }).then((value) {
              Get.close(1);
              Get.offAllNamed('/splash');
            });
          } else {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              'password': password,
            }).then((value) {
              Get.close(1);
              Get.offAllNamed('/splash');
            });
          }
        } on FirebaseAuthException catch (e) {
          Get.close(1);
          if (e.code == 'wrong-password') {
            Get.snackbar("Thông báo", "Mật khẩu sai",
                colorText: Colors.white, backgroundColor: Colors.red);
          }
          print(e.toString());
        }
      } else {
        Get.close(1);
        Get.snackbar("Thông báo", "Số điện thoại chưa đăng ký",
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    });
  }

  checkPhoneActive() async {
    String phone = "0${maskFormatter.getUnmaskedText()}";
    await FirebaseFirestore.instance
        .collection('users')
        .where('phone', isEqualTo: phone)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        print(phone);
        UserModel userModel = UserModel.fromJson(value.docs.first.data());
        if (userModel.verified) {
          signIn();
        } else {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: userModel.email, password: userModel.password);
          DiaLog.showDiaLogYN(
            title: 'Thông báo',
            content:
                'Tài khoản của chưa xác thực số điện thoại, vui lòng xác nhận',
            accept: () => verifiedPhone(phone, userModel),
          );
        }
      } else {
        Get.snackbar("Thông báo", "Số điện thoại chưa đăng ký",
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    });
  }

  int generateRandom6DigitNumber() {
    var random = Random();
    return random.nextInt(999999) + 100000;
  }

  verifiedPhone(String phone, UserModel user) async {
    Get.close(1);
    DiaLog.showIndicatorDialog();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update({"phone": phone});
    String code = generateRandom6DigitNumber().toString();
    String message =
        'PhoenixPay: Ma OTP $code su dung de xac thuc tai khoan. Tran trong!';
    await SMSProvider().sendSMS(message, phone).whenComplete(() {
      Get.close(1);
      Get.to(() => VerifiedPhonePage(), arguments: [phone, code]);
    });
  }

  // verifiedPhone(String temp, UserModel user) async {
  //   // close dialog
  //   Get.close(1);
  //   DiaLog.showIndicatorDialog();
  //   var phone = "+84";
  //   await FirebaseFirestore.instance.collection('users')
  //       .doc(user.id)
  //       .update({"phone": temp});
  //
  //   if (temp.startsWith('0')) {
  //     phone = phone + temp.substring(1);
  //   } else {
  //     phone = phone + temp;
  //   }
  //
  //   print(phone);
  //   // if run ios add URL Schemes in Xcode -> Info -> URL Types
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: phone,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       Get.close(1);
  //
  //       if (e.code == 'invalid-phone-number') {
  //         Get.snackbar('Thông báo', "Số điện thoại đã cung cấp không hợp lệ.",
  //           colorText: Colors.white,
  //           backgroundColor: Colors.redAccent,
  //         );
  //       }
  //       else if(e.code == 'too-many-requests') {
  //         Get.snackbar('Thông báo', "Chúng tôi đã chặn tất cả các yêu cầu từ thiết bị này do hoạt động bất thường. Thử lại sau",
  //           colorText: Colors.white,
  //           backgroundColor: Colors.redAccent,
  //         );
  //       }
  //       else {
  //
  //         Get.snackbar('Thông báo', "${e}",
  //           colorText: Colors.white,
  //           backgroundColor: Colors.redAccent,
  //         );
  //       }
  //
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       Get.close(1);
  //       Get.to(() => VerifiedPhonePage(), arguments: [phoneController.text, verificationId]);
  //     },
  //
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //
  //     },
  //   );
  // }

  signInCustomer() async {
    String phone = "0${maskFormatter.getUnmaskedText()}";
    String password = passwordController.text.trim();
    await FirebaseFirestore.instance
        .collection('customer')
        .where('phone', isEqualTo: phone)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        DiaLog.showIndicatorDialog();
        CustomerModel user = CustomerModel.fromJson(value.docs.first.data());
        String email = user.email;
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          // set phone for face id
          LocalStorageService.setValue("phone", phone);
          await FirebaseFirestore.instance
              .collection('customer')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            'password': password,
          }).then((value) {
            Get.close(1);
            Get.offAllNamed('/splash');
          });
        } on FirebaseAuthException catch (e) {
          Get.close(1);
          if (e.code == 'wrong-password') {
            Get.snackbar("Thông báo", "Mật khẩu sai",
                colorText: Colors.white, backgroundColor: Colors.red);
          }
        }
      } else {
        Get.close(1);
        Get.snackbar("Thông báo", "Số điện thoại chưa đăng ký",
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    });
  }
}
