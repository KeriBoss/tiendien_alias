import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/data/dummy_data.dart';
import 'package:tiendien_alias/pages/forgot_password/forgot_password.dart';
import 'package:tiendien_alias/pages/login/loginController.dart';
import 'package:tiendien_alias/pages/login/loginPasswordPage.dart';

class LoginPage extends StatelessWidget {
  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff73B5E8),
          Color(0xffCDEEC7),
        ], transform: GradientRotation(167))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 61),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.offNamed('/welcome');
                        },
                        child: const Icon(Icons.arrow_back)),
                    const SizedBox(
                      height: 17,
                    ),
                    Text(
                      'Nhập số điện thoại',
                      style: TextStyles.defaultStyle.semiBold.setTextSize(24),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100.h,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13),
                    )),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 151,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: TextFormField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            controller.maskFormatter,
                          ],
                          style: TextStyles.defaultStyle.setTextSize(23).medium,
                          autofocus: true,
                          decoration: InputDecoration(
                              prefixText: "+84 ",
                              prefixStyle: TextStyles.defaultStyle
                                  .setTextSize(23)
                                  .medium,
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                          validator: (value) {
                            if (value!.length != 11) {
                              return 'Vui lòng nhập số điện thoại';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 139,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorPalette.blackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(37)),
                            ),
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                Get.to(() => LoginPasswordPage());
                              }
                            },
                            child: Text(
                              "Tiếp tục",
                              style:
                                  TextStyles.defaultStyle.whiteTextColor.medium,
                            )),
                      ),
                      const SizedBox(
                        height: 37,
                      ),
                      if (DateTime.now().isAfter(dateShow))
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                Get.to(() => ForgotPasswordScreen());
                              },
                              child: Text("Quên mật khẩu",
                                  style: TextStyles.defaultStyle.medium
                                      .setTextSize(16)
                                      .setColor(Color(0xff20577A))),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
