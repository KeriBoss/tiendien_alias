import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ChangePassController.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đổi mật khẩu'),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset("assets/pngs/changepass.png"),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Thay đổi mật khẩu ?",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Vui lòng nhập thông tin tài khoản và mật khẩu để đổi",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(() => changePasswordController.currentUser.value != null
                      ? Form(
                          key: changePasswordController.formKey,
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: changePasswordController
                                      .passwordController,
                                  decoration: const InputDecoration(
                                    labelText: "Mật khẩu cũ",
                                  ),
                                  obscureText: true,
                                  validator: (value) => validatorPasswordLength(
                                      changePasswordController
                                          .passwordController.text,
                                      8),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: changePasswordController
                                      .passwordNewController,
                                  decoration: const InputDecoration(
                                    labelText: "Mật khẩu mới",
                                  ),
                                  obscureText: true,
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
                                    } else if (!RegExp(r'[0-9]')
                                        .hasMatch(value)) {
                                      return 'Mật khẩu phải bao gồm ít nhất\n1 chữ số';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: changePasswordController
                                      .confirmPasswordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: "Nhập lại mật khẩu",
                                  ),
                                  validator: (value) => validateVerifyPassword(
                                      changePasswordController
                                          .passwordNewController.text,
                                      value!),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (changePasswordController
                                          .formKey.currentState!
                                          .validate()) {
                                        changePasswordController
                                            .changePassword(context);
                                      }
                                    },
                                    child: const Text(
                                      'Đổi mật khẩu',
                                      style: TextStyle(
                                          color: ColorConstants.whiteColor),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
