import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/data/dummy_data.dart';
import 'package:tiendien_alias/pages/profile_qr/profile_qr_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirectIntroPage();
  }

  void redirectIntroPage() async {
    await Future.delayed(const Duration(seconds: 2));
    DateTime now = DateTime.now();
    if (FirebaseAuth.instance.currentUser != null) {
      if (now.isAfter(dateShow)) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) {
          if (value.exists) {
            if (value['isBlock'] == false) {
              if (value['verified'] == true) {
                if (value['role'] == 2 || value['role'] == 1) {
                  Get.back();
                  Get.offNamed("/bottomNavBarCustomer");
                }
                if (value['role'] == 0) {
                  Get.back();
                  Get.toNamed("/home");
                }
              } else {
                Get.toNamed("/welcome");
              }
            } else {
              Get.toNamed('/login');
              Get.snackbar(
                "Thông báo",
                "Tài khoản của bạn đang bị khoá, Vui lòng liên hệ với admin!!!",
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
              );
            }
          } else {
            Get.toNamed("/welcome");
          }
        });
      } else {
        print(FirebaseAuth.instance.currentUser!.uid);
        FirebaseFirestore.instance
            .collection('customer')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) {
          if (value.exists) {
            Get.off(() => ProfileQRPage());
          } else {
            Get.toNamed("/welcome");
          }
        });
      }
    } else {
      print('object');
      Get.toNamed("/welcome");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: kIsWeb ? Get.width / 4 : Get.width,
            height: kIsWeb ? Get.width / 4 : Get.width,
            child: Image.asset("assets/pngs/logo.png"),
          ),
          SizedBox(
            height: Get.width > 854 ? Get.height / 6 : Get.height / 3,
          ),
          Text(
            'Đang tải ... ',
            style: TextStyles.defaultStyle
                .setTextSize(16)
                .setColor(ColorPalette.primaryColor),
          )
        ],
      ),
    ));
  }
}
