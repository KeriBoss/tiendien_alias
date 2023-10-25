import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/login/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CongratulationPage extends StatelessWidget {
  Future<bool> onWillPop() async {
    return (await Get.dialog(
          AlertDialog(
            title: const Text(
              'Thông báo',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            content: const Text('Bạn muốn thoát ứng dụng ?'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Không'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.close(1);
                      SystemNavigator.pop();
                    },
                    child: const Text('Thoát'),
                  ),
                ],
              )
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 159,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 128, right: 105),
              child: Image(
                  image: Image.asset(
                'assets/pngs/congratulation.png',
                height: 166,
              ).image),
            ),
            const SizedBox(
              height: 28,
            ),
            Center(
                child: Text(
              "Chúc mừng! Bạn đã tạo thành",
              style: TextStyles.defaultStyle.medium.setTextSize(16),
            )),
            const SizedBox(
              height: 3,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'công tài khoản trên ',
                  style: TextStyles.defaultStyle.medium.setTextSize(16),
                ),
                TextSpan(
                    text: 'Phoenix Pay',
                    style: TextStyles.defaultStyle.medium
                        .setTextSize(16)
                        .setColor(const Color(0xff62C196))),
              ])),
            ),
            const SizedBox(
              height: 69,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.blackColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(37))),
                  onPressed: () {
                    Get.offAll(() => LoginPage());
                  },
                  child: Text(
                    "Đăng nhập ngay!",
                    style: TextStyles.defaultStyle.whiteTextColor.medium,
                  )),
            ),
            const SizedBox(
              height: 150,
            ),
            Center(
                child: Image.asset(
              'assets/pngs/logo_small.png',
              width: 32,
              height: 32,
            ))
          ],
        ),
      ),
    );
  }
}
