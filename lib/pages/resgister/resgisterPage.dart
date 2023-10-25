import 'dart:io';

import 'package:tiendien_alias/Sevice/local_auth_service.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/resgister/verifiedPhone/verifiedPhonePage.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'resgisterController.dart';

class RegisterPage extends StatelessWidget {
  var controller = Get.put(RegisterController());

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
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.close(1);
                        },
                        child: const Icon(Icons.arrow_back)),
                    const SizedBox(
                      width: 70,
                    ),
                    Text(
                      'Đăng ký tài khoản',
                      style: TextStyles.defaultStyle.medium.setTextSize(18),
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title('Họ và tên'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: controller.usernameController,
                            decoration: const InputDecoration(
                              hintText: 'Nhập họ và tên của bạn',
                            ),
                            validator: (value) => validatorText(value!),
                          ),
                        ),
                        title('Số điện thoại'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: controller.phoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                                hintText: 'Nhập số điện thoại'),
                            validator: (value) => validatorPhoneNumber(value!),
                          ),
                        ),
                        title('Mã giới thiệu (nếu có)'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: controller.referralCode,
                            decoration: const InputDecoration(
                                hintText: 'Nhập mã giới thiệu'),
                          ),
                        ),
                        Obx(() {
                          return Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 24, top: 24),
                                width: 177,
                                height: 32,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xffB8B8B8),
                                      width: 1,
                                    )),
                                child: Center(
                                  child: Text(
                                    controller.strRandom.value,
                                    style: TextStyles.defaultStyle,
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 6,
                                  bottom: 6,
                                  child: InkWell(
                                      onTap: () {
                                        controller.randomNumber();
                                      },
                                      child: const Icon(
                                        Icons.replay,
                                        size: 20,
                                      )))
                            ],
                          );
                        }),
                        title('Mã Captcha'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: controller.captchaController,
                            decoration: const InputDecoration(
                                hintText: 'Nhập mã Capcha'),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == '') {
                                return "Vui lòng không để trống";
                              } else if (value!.toLowerCase() !=
                                  controller.strRandom.value.toLowerCase()) {
                                return "Sai mã. Vui lòng thử lại!";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Obx(() {
                          return CheckboxListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 24),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Xác nhận bạn đã ',
                                    style: TextStyles.defaultStyle
                                        .setTextSize(12)),
                                TextSpan(
                                    text: 'đủ 18 tuổi',
                                    style: TextStyles.defaultStyle
                                        .setTextSize(12)
                                        .setColor(const Color(0xff22587A))),
                                TextSpan(
                                    text: ', là ',
                                    style: TextStyles.defaultStyle
                                        .setTextSize(12)),
                                TextSpan(
                                    text: 'công dân Việt Nam ',
                                    style: TextStyles.defaultStyle
                                        .setTextSize(12)
                                        .setColor(const Color(0xff22587A))),
                                TextSpan(
                                    text:
                                        'và là người cư trú, không có dấu hiệu là ',
                                    style: TextStyles.defaultStyle
                                        .setTextSize(12)),
                                TextSpan(
                                    text: 'người ngoài hành tinh ',
                                    style: TextStyles.defaultStyle
                                        .setTextSize(12)
                                        .setColor(const Color(0xff22587A))),
                                TextSpan(
                                    text: 'và tuân thủ ',
                                    style: TextStyles.defaultStyle
                                        .setTextSize(12)),
                                TextSpan(
                                    text: 'Điều kiện & Điều khoản sử dụng ',
                                    style: TextStyles.defaultStyle
                                        .setTextSize(12)
                                        .setColor(const Color(0xff62C196))),
                                TextSpan(
                                    text: 'của chúng tôi.',
                                    style: TextStyles.defaultStyle
                                        .setTextSize(12)),
                              ]),
                            ),
                            value: controller.isCheck.value,
                            checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              // side:const BorderSide(
                              //   color: Color(0xff91CD91),
                              //   width: 1
                              // )
                            ),
                            checkColor: Colors.white,
                            activeColor: const Color(0xff91CD91),
                            onChanged: (value) {
                              controller.isCheck.value =
                                  !controller.isCheck.value;
                            },
                          );
                        }),
                        const SizedBox(
                          height: 99,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorPalette.blackColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(37))),
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  if (controller.isCheck.value) {
                                    controller.updateInformationUser();
                                  } else {
                                    Get.snackbar(
                                      'Thông báo',
                                      'Vui lòng xác nhận điền kiện và điều khoản sử dụng của chúng tôi',
                                      colorText: Colors.white,
                                      backgroundColor: Colors.redAccent,
                                    );
                                  }
                                }
                              },
                              child: Text(
                                "Tiếp tục",
                                style: TextStyles
                                    .defaultStyle.whiteTextColor.medium,
                              )),
                        ),
                        const SizedBox(
                          height: 49,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildFaceId() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                if (controller.supportFaceID.value) {
                  final authenticate = await LocalAuth.authenticate();
                  controller.authenticated.value = authenticate;
                } else {
                  Get.defaultDialog(
                      title: 'Thông báo',
                      content: const Text('Thiết bị này không hỗ trợ Face ID'));
                }
              },
              child: const Text("Authenticate")),
          Obx(() {
            return controller.authenticated.value
                ? const Text("You are authenticated")
                : Container();
          }),
          Obx(() {
            return controller.authenticated.value
                ? ElevatedButton(
                    onPressed: () {
                      controller.authenticated.value = false;
                    },
                    child: const Text("Logout"))
                : Container();
          })
        ],
      ),
    );
  }

  Widget title(String hintText) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 24, bottom: 8),
      child: Text(
        hintText,
        style: TextStyles.defaultStyle,
      ),
    );
  }
}
