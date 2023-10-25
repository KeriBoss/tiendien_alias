import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'createdAccountController.dart';

class CreatedAccountPage extends StatelessWidget {
  var controller = Get.put(CreatedAccountController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
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
                        'Tạo tài khoản mới',
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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13),
                      )),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 151,
                        ),
                        TextFormField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              hintText: 'Số điện thoại',
                              suffixIcon: InkWell(
                                  onTap: () {
                                    controller.phoneController.clear();
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    size: 24,
                                    color: Colors.black,
                                  )),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              ),
                              enabledBorder: const UnderlineInputBorder(),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent),
                              )),
                          validator: (value) => validatorPhoneNumber(value!),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          controller: controller.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Mật khẩu',
                              suffixIcon: InkWell(
                                  onTap: () {
                                    controller.passwordController.clear();
                                    controller.isCheck1.value = false;
                                    controller.isCheck2.value = true;
                                    controller.isCheck3.value = true;
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    size: 24,
                                    color: Colors.black,
                                  )),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              ),
                              enabledBorder: const UnderlineInputBorder(),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent),
                              )),
                          onChanged: (value) {
                            if (value.length >= 8) {
                              controller.isCheck1.value = true;
                            }
                            if (value.length < 8) {
                              controller.isCheck1.value = false;
                            }

                            if (RegExp(r'[@#\\$&*~]')
                                .allMatches(value)
                                .isEmpty) {
                              controller.isCheck2.value = true;
                            }

                            if (RegExp(r'[@#\\$&*~]')
                                .allMatches(value)
                                .isNotEmpty) {
                              controller.isCheck2.value = false;
                            }

                            if (!RegExp(r'[0-9]').hasMatch(value)) {
                              controller.isCheck3.value = true;
                            }

                            if (RegExp(r'[0-9]').hasMatch(value)) {
                              controller.isCheck3.value = false;
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            } else if (value.length < 8) {
                              return 'Mật khẩu phải ít nhất 8 ký tự';
                            } else if (RegExp(r'[@#\\$&*~]')
                                    .allMatches(value)
                                    .length >
                                3) {
                              return 'Mật khẩu bao gồm tối đa 3\nký tự đặc biệt(@,#,\$,..)';
                            } else if (RegExp(r'[@#\\$&*~]')
                                .allMatches(value)
                                .isEmpty) {
                              return 'Mật khẩu bao gồm ít nhất 1\nký tự đặc biệt(@,#,\$,..)';
                            } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                              return 'Mật khẩu phải bao gồm ít nhất\n1 chữ số';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          controller: controller.confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Nhập lại mật khẩu',
                              suffixIcon: InkWell(
                                  onTap: () {
                                    controller.confirmPasswordController
                                        .clear();
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    size: 24,
                                    color: Colors.black,
                                  )),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              ),
                              enabledBorder: const UnderlineInputBorder(),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent),
                              )),
                          validator: (value) => validateVerifyPassword(
                              controller.passwordController.text, value!),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Obx(() {
                          return controller.isCheck1.value == false
                              ? Text(
                                  '• Mật khẩu phải ít nhất 8 ký tự',
                                  style: TextStyles.defaultStyle
                                      .setTextSize(12)
                                      .setColor(const Color(0xffB8B8B8)),
                                )
                              : RichText(
                                  text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '• Mật khẩu phải ít nhất 8 ký tự',
                                      style: TextStyles.defaultStyle
                                          .setTextSize(12),
                                    ),
                                    WidgetSpan(
                                        child: Image.asset(
                                            "assets/pngs/icCheck.png",
                                            width: 18,
                                            height: 18))
                                  ],
                                ));
                        }),
                        const SizedBox(
                          height: 4,
                        ),
                        Obx(() {
                          return controller.isCheck2.value
                              ? Text(
                                  '• Mật khẩu bao gồm tối thiểu 1 ký tự đặc biệt(@,#,\$,..)',
                                  style: TextStyles.defaultStyle
                                      .setTextSize(12)
                                      .setColor(const Color(0xffB8B8B8)),
                                )
                              : RichText(
                                  text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '• Mật khẩu bao gồm tối thiểu 3 ký tự đặc biệt(@,#,\$,..)',
                                      style: TextStyles.defaultStyle
                                          .setTextSize(12),
                                    ),
                                    WidgetSpan(
                                        child: Image.asset(
                                            "assets/pngs/icCheck.png",
                                            width: 18,
                                            height: 18))
                                  ],
                                ));
                        }),
                        const SizedBox(
                          height: 4,
                        ),
                        Obx(() {
                          return controller.isCheck3.value
                              ? Text(
                                  '• Mật khẩu phải bao gồm ít nhất 1 chữ số',
                                  style: TextStyles.defaultStyle
                                      .setTextSize(12)
                                      .setColor(const Color(0xffB8B8B8)),
                                )
                              : RichText(
                                  text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '• Mật khẩu phải bao gồm ít nhất 1 chữ số',
                                      style: TextStyles.defaultStyle
                                          .setTextSize(12),
                                    ),
                                    WidgetSpan(
                                        child: Image.asset(
                                            "assets/pngs/icCheck.png",
                                            width: 18,
                                            height: 18))
                                  ],
                                ));
                        }),
                        const SizedBox(
                          height: 14,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorPalette.blackColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(37))),
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.createdAccount();
                              }
                            },
                            child: Text(
                              "Tạo tài khoản mới",
                              style:
                                  TextStyles.defaultStyle.whiteTextColor.medium,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
