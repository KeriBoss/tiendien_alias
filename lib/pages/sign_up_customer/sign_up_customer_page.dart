import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'sign_up_customer_controller.dart';

class SignUpCustomerPage extends StatelessWidget {
  var controller = Get.put(SignUpCustomerController());

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
                            controller: controller.nameController,
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
                        title('CCCD (Nếu có)'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: controller.cccdController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration:
                                const InputDecoration(hintText: 'Nhập CCCD'),
                          ),
                        ),
                        title('Mật khẩu'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: controller.passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: 'Nhập mật khẩu'),
                            validator: (value) =>
                                validatorPasswordLength(value!, 8),
                          ),
                        ),
                        title('Nhập lại mật khẩu'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: 'Nhập lại mật khẩu'),
                            validator: (value) => validateVerifyPassword(
                                controller.passwordController.text, value!),
                          ),
                        ),
                        Obx(() {
                          return CheckboxListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 24),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              "Cho phép tìm kiếm danh thiếp, thông tin cá nhân của những người muốn chia sẽ",
                              style: TextStyles.defaultStyle.medium
                                  .setTextSize(14),
                            ),
                            value: controller.isShow.value,
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
                              controller.isShow.value =
                                  !controller.isShow.value;
                            },
                          );
                        }),
                        const SizedBox(
                          height: 20,
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
                                  controller.signUpCustomer(context);
                                }
                              },
                              child: Text(
                                "Đăng ký",
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
