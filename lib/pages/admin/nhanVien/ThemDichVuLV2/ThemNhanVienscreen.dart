import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../ThemNhanVien/themNhanViencontroller.dart';
import '/constants/color_constants.dart';
import '/constants/font_constants.dart';
import '/widgets/screen_top.dart';
import 'package:get/get.dart';

class ThemNhanVienScreen extends StatelessWidget {
  ThemNhanVienScreen({Key? key}) : super(key: key);
  final ThemNhanVienController _signUpController =
      Get.put(ThemNhanVienController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScreenTop('Thêm nhân viên'),
            SizedBox(
              height: 5.h,
            ),
            Form(
              key: _signUpController.formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.5.w),
                child: Column(
                  children: [
                    TextFormField(
                        controller: _signUpController.userNameController,
                        decoration:
                            const InputDecoration(label: Text('Tên của bạn')),
                        validator: (item) => validatorLength(
                            _signUpController.userNameController.text, 4)),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                        controller: _signUpController.emailController,
                        decoration: const InputDecoration(label: Text('Email')),
                        validator: (item) => validatorEmail(
                            _signUpController.emailController.text)),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      controller: _signUpController.passwordController,
                      decoration: const InputDecoration(
                        label: Text('Mật khẩu'),
                      ),
                      validator: (item) => validatorPasswordLength(
                          _signUpController.emailController.text, 6),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    TextFormField(
                        controller: _signUpController.addressController,
                        decoration: const InputDecoration(
                          label: Text('Địa chỉ'),
                        ),
                        maxLines: 7,
                        validator: (item) => validatorLength(
                            _signUpController.addressController.text, 1)),
                    SizedBox(
                      height: 4.h,
                    ),
                    TextFormField(
                        controller: _signUpController.phoneController,
                        decoration: const InputDecoration(
                          label: Text('Số điện thoại'),
                        ),
                        validator: (item) => validatorPhoneNumber(
                            _signUpController.phoneController.text)),
                    SizedBox(
                      height: 4.h,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_signUpController.formKey.currentState!
                              .validate()) {
                            _signUpController.signUpValidate(context);
                          }
                        },
                        child: const Text(
                          'Tạo tài khoản',
                          style: TextStyle(color: ColorConstants.primaryColor),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 2.h,
                        bottom: 3.h,
                      ),
                      child: Text(
                        'Hoặc',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bạn đã có tài khoản ? ',
                          style: TextStyle(
                            fontFamily: FontConstants.comfortaaBold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text(' Đăng nhập'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
