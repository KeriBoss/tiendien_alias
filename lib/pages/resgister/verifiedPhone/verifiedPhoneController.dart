import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/resgister/congratulation/congratulationPage.dart';
import 'package:tiendien_alias/pages/resgister/verifiedCCCD/verifiedCCCDPage.dart';
import 'package:tiendien_alias/provider/sms_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerifiedPhoneController extends GetxController {
  String phone = Get.arguments[0];
  String code = Get.arguments[1];
  var pinController = TextEditingController();

  Timer? _timer;

  final RxInt timeStart = 59.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (timeStart.value == 0) {
        timer.cancel();
      } else {
        timeStart.value--;
      }
    });
  }

  int generateRandom6DigitNumber() {
    var random = Random();
    return random.nextInt(999999) + 100000;
  }

  Future<void> sendAgain() async {
    timeStart.value = 59;
    DiaLog.showIndicatorDialog();

    var phoneTemp = "+84";
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"phone": phone});

    // if (phone[0] == "0") {
    //   phoneTemp = phoneTemp + phone.substring(1);
    // } else {
    //   phoneTemp = phoneTemp + phone;
    // }
    code = generateRandom6DigitNumber().toString();
    String message =
        'PhoenixPay: Ma OTP $code su dung de xac thuc tai khoan. Tran trong!';
    await SMSProvider().sendSMS(message, phone);

    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: phoneTemp,
    //   verificationCompleted: (PhoneAuthCredential credential) async {
    //
    //   },
    //   verificationFailed: (FirebaseAuthException e) {
    //     Get.close(1);
    //     if (e.code == 'invalid-phone-number') {
    //       Get.snackbar('Thông báo', "Số điện thoại đã cung cấp không hợp lệ.",
    //         colorText: Colors.white,
    //         backgroundColor: Colors.redAccent,
    //       );
    //     } else {
    //       Get.snackbar('Thông báo', "Một cái gì đó đã đi sai. Thử lại",
    //         colorText: Colors.white,
    //         backgroundColor: Colors.redAccent,
    //       );
    //     }
    //
    //   },
    //   codeSent: (String verificationId, int? resendToken) {
    //     this.verificationId = verificationId;
    //     Get.close(1);
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //
    //   },
    // );
  }

  void verifyOTP(String otp) async {
    DiaLog.showIndicatorDialog();

    if (code == otp) {
      Get.close(1);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'verified': true});

      DiaLog.showDiaLogOke(
          title: 'Thông báo',
          content: 'Xác thực thành công',
          accept: () {
            Get.offAll(() => CongratulationPage());
          });
    } else {
      Get.close(1);
      Get.defaultDialog(
          title: 'Thông báo', content: const Text('Xác thực thất bại.'));
    }
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
