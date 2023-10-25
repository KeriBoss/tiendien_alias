import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/localStorageService.dart';
import 'package:tiendien_alias/Sevice/local_auth_service.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class WelcomeController extends GetxController {
  RxBool authenticated = RxBool(false);
  final _auth = LocalAuthentication();
  RxBool supportFaceID = RxBool(false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // check device support face id
    if (!kIsWeb) {
      _auth.isDeviceSupported().then((value) {
        supportFaceID.value = value;
      });
    }
  }

  signInFaceID(String phone) async {
    final authenticate = await LocalAuth.authenticate();
    authenticated.value = authenticate;

    // success
    if (authenticated.value) {
      DiaLog.showIndicatorDialog();
      await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: phone)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          UserModel user = UserModel.fromJson(value.docs.first.data());
          String email = user.email;
          String password = user.password;
          try {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password);
            final fcmToken = await FirebaseMessaging.instance.getToken();

            // set phone for face id
            LocalStorageService.setValue("phone", phone);

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
          } on FirebaseAuthException catch (e) {
            Get.close(1);
          }
        } else {
          Get.close(1);
        }
      });
    } else {
      Get.defaultDialog(
          title: 'Thông báo',
          content: const Text('Face ID không hợp lệ, vui lòng thử lại'));
    }
  }

  checkSignFirst() {
    if (supportFaceID.value) {
      final checkPhone = LocalStorageService.getValue('phone') as String?;
      if (checkPhone != null && checkPhone != '') {
        signInFaceID(checkPhone);
      } else {
        Get.defaultDialog(
            title: 'Thông báo', content: const Text("Vui lòng đăng nhập"));
      }
    } else {
      Get.defaultDialog(
          title: 'Thông báo',
          content: const Text('Thiết bị này không hỗ trợ Face ID'));
    }
  }
}
