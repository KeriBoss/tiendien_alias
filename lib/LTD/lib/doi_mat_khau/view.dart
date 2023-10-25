import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tiendien_alias/LTD/lib/constants/color_constants.dart';
import 'package:tiendien_alias/LTD/lib/validate/validate.dart';

import 'logic.dart';

class DoiMatKhauPage extends StatelessWidget {
  final logic = Get.put(DoiMatKhauLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.only(left: 10, right: 10),
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
                        width: 95.w,
                        height: 27.h,
                        child: Image.asset(
                          "assets/images/logo.jpg",
                          height: 25.h,
                          width: 100.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
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
                      Text(
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
                SizedBox(
                  height: 30,
                ),
                Obx(() => logic.currentUser.value != null
                    ? Form(
                        key: logic.formKey,
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                enabled: false,
                                controller: logic.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "E-mail",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: logic.passwordNewController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Mật khẩu mới",
                                ),
                                obscureText: true,
                                validator: (value) => validatorPassword(
                                    logic.passwordNewController.text, 6),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: logic.confirmPasswordController,
                                keyboardType: TextInputType.emailAddress,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Nhập lại mật khẩu",
                                ),
                                validator: (value) => validatorConfirmPassword(
                                    logic.passwordNewController.text,
                                    logic.confirmPasswordController.text),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if (logic.formKey.currentState!
                                        .validate()) {
                                      logic.ChangePassword(context);
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
    );
    return Container();
  }
}
