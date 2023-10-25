import 'dart:async';

import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/data/dummy_data.dart';
import 'package:tiendien_alias/pages/login/loginPage.dart';
import 'package:tiendien_alias/pages/resgister/createdAccount/createdAccountPage.dart';
import 'package:tiendien_alias/pages/resgister/resgisterPage.dart';
import 'package:tiendien_alias/pages/sign_up_customer/sign_up_customer_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'welcomeController.dart';

class WelcomePage extends StatelessWidget {
  var controller = Get.put(WelcomeController());

  void countdownIsolate(int time) {
    int initialTime = time; // Thời gian ban đầu
    int remainingTime = initialTime;

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      remainingTime--;

      if (remainingTime <= 0) {
        timer.cancel();
        print('Countdown finished.');
        FlutterIsolate.current.kill();
        // Thực hiện các tác vụ cần thiết khi đếm ngược kết thúc.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 9.h, bottom: 13),
                child: Image.asset(
                  'assets/pngs/logo.png',
                  height: 80,
                  width: 80,
                ),
              ),
              Text(
                'Phoenix Pay\nxin chào!',
                style: GoogleFonts.inter(
                    textStyle: TextStyles.defaultStyle.semiBold
                        .setTextSize(40)
                        .setColor(const Color(0xFF121212))),
              ),
              SizedBox(
                height: 29.h,
              ),
              buildFaceId(),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.blackColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(37))),
                  onPressed: () async {
                    Get.to(() => LoginPage());
                  },
                  child: Text(
                    "Đăng nhập",
                    style: TextStyles.defaultStyle.whiteTextColor.medium,
                  )),
              const SizedBox(
                height: 16,
              ),
              OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        color: ColorPalette.blackColor, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(37),
                    ),
                    minimumSize: Size(100.w, 5.h),
                    padding: EdgeInsets.symmetric(vertical: 2.3.h),
                  ),
                  onPressed: () {
                    DateTime now = DateTime.now();
                    if (now.isAfter(dateShow)) {
                      Get.to(() => RegisterPage());
                    } else {
                      Get.to(() => SignUpCustomerPage());
                    }
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                          text: 'Bạn chưa có tài khoản? ',
                          style: TextStyles.defaultStyle),
                      TextSpan(
                          text: 'Đăng ký',
                          style: TextStyles.defaultStyle
                              .setColor(const Color(0xff38A3A6))),
                    ]),
                  )),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFaceId() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.checkSignFirst();
          },
          child: Center(
            child: Image.asset(
              'assets/pngs/face_id.png',
              width: 48,
              height: 48,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Center(
          child: Text(
            "Face ID",
            style: TextStyles.defaultStyle,
          ),
        ),
      ],
    );
  }
}
