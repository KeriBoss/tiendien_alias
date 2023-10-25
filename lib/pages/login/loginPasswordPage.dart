import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/data/dummy_data.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'loginController.dart';

class LoginPasswordPage extends StatelessWidget {
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
                          Get.close(1);
                        },
                        child: const Icon(Icons.arrow_back)),
                    const SizedBox(
                      height: 17,
                    ),
                    Text(
                      'Nhập số mật khẩu',
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
                  key: controller.formKeyPass,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 151,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: TextFormField(
                          controller: controller.passwordController,
                          style: TextStyles.defaultStyle.setTextSize(24).medium,
                          autofocus: true,
                          obscureText: true,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () {
                                    controller.passwordController.clear();
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                  )),
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                          validator: (value) => validatorText(value!),
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
                              if (controller.formKeyPass.currentState!
                                  .validate()) {
                                DateTime now = DateTime.now();
                                if (now.isAfter(dateShow)) {
                                  controller.checkPhoneActive();
                                } else {
                                  controller.signInCustomer();
                                }
                              }
                            },
                            child: Text(
                              "Tiếp tục",
                              style:
                                  TextStyles.defaultStyle.whiteTextColor.medium,
                            )),
                      ),
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
