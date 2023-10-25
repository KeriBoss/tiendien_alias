import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'change_password_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  var controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          AppBarWidget(hintText: 'Đổi mật khẩu'),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: controller.currentPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Mật khẩu hiện tại',
                        suffixIcon: InkWell(
                            onTap: () {
                              controller.currentPasswordController.clear();
                            },
                            child: const Icon(
                              Icons.clear,
                              size: 18,
                              color: Colors.black,
                            )),
                        border: ColorPalette.underLineCyan,
                        focusedBorder: ColorPalette.underLineCyan,
                        enabledBorder: const UnderlineInputBorder(),
                        errorBorder: ColorPalette.underLineRed),
                    onChanged: (value) {},
                    validator: (value) => validatorText(value!),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: controller.newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Mật khẩu mới',
                        suffixIcon: InkWell(
                            onTap: () {
                              controller.newPasswordController.clear();
                              controller.isCheck1.value = false;
                              controller.isCheck2.value = true;
                              controller.isCheck3.value = true;
                            },
                            child: const Icon(
                              Icons.clear,
                              size: 18,
                              color: Colors.black,
                            )),
                        border: ColorPalette.underLineCyan,
                        focusedBorder: ColorPalette.underLineCyan,
                        enabledBorder: const UnderlineInputBorder(),
                        errorBorder: ColorPalette.underLineRed),
                    onChanged: (value) {
                      if (value.length >= 8) {
                        controller.isCheck1.value = true;
                      }
                      if (value.length < 8) {
                        controller.isCheck1.value = false;
                      }

                      if (RegExp(r'[@#\\$&*~]').allMatches(value).isEmpty) {
                        controller.isCheck2.value = true;
                      }

                      if (RegExp(r'[@#\\$&*~]').allMatches(value).isNotEmpty) {
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
                              controller.confirmPasswordController.clear();
                            },
                            child: const Icon(
                              Icons.clear,
                              size: 18,
                              color: Colors.black,
                            )),
                        border: ColorPalette.underLineCyan,
                        focusedBorder: ColorPalette.underLineCyan,
                        enabledBorder: const UnderlineInputBorder(),
                        errorBorder: ColorPalette.underLineRed),
                    onChanged: (value) {},
                    validator: (value) => validateVerifyPassword(
                        controller.newPasswordController.text, value!),
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
                                style: TextStyles.defaultStyle.setTextSize(12),
                              ),
                              WidgetSpan(
                                  child: Image.asset("assets/pngs/icCheck.png",
                                      width: 18, height: 18))
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
                                style: TextStyles.defaultStyle.setTextSize(12),
                              ),
                              WidgetSpan(
                                  child: Image.asset("assets/pngs/icCheck.png",
                                      width: 18, height: 18))
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
                                style: TextStyles.defaultStyle.setTextSize(12),
                              ),
                              WidgetSpan(
                                  child: Image.asset("assets/pngs/icCheck.png",
                                      width: 18, height: 18))
                            ],
                          ));
                  }),
                  SizedBox(
                    height: 8.5.h,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPalette.blackColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(37))),
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          if (controller.isFaceId) {
                            controller.checkFaceID();
                          } else {
                            await controller.changePassword(
                                controller.newPasswordController.text.trim());
                          }
                        }
                      },
                      child: Text(
                        "Xác nhận",
                        style: TextStyles.defaultStyle.whiteTextColor.medium,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
