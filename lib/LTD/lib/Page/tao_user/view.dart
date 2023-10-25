import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/constants/theme_data2.dart';
import 'package:tiendien_alias/LTD/lib/validate/validate.dart';

import 'logic.dart';

class TaoUserPage extends StatelessWidget {
  final logic = Get.put(TaoUserLogic());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Theme(
        data: getAppThemeDataSecond(),
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Scaffold(
            appBar: AppBar(title: const Text('Tạo tài khoản gia công'),),
            backgroundColor: Colors.white,
            body:    SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.center,
                    child: Form(
                      key: logic.keys,
                      child: Column(
                        children: [
                          TextFormField(
                              controller: logic.email,
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Email tài khoản đăng nhập'),
                              validator: (val) => validatorEmail(val.toString())
                            // if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                            //   return "Enter a valid email address";
                            // }
                            // return null;

                          ),
                          const SizedBox(height: 17.5),
                          TextFormField(
                              controller: logic.username,
                              decoration: const InputDecoration(
                                  labelText: 'Username',
                                  hintText: 'Nhập tên của bạn'),
                              validator: (value) {
                                return validatorText(value.toString());
                              }),
                          const SizedBox(height: 17.5),
                          TextFormField(
                              controller: logic.address,
                              decoration: const InputDecoration(
                                  labelText: "Địa chỉ",
                                  hintText: "Nhập địa chỉ của bạn"),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                return validatorText(value.toString());
                              }),
                          const SizedBox(height: 17.5),
                          TextFormField(
                            controller: logic.phoneNumber,
                            decoration: const InputDecoration(
                                labelText: "Số điện thoại",
                                hintText: "Nhập số điện thoại của bạn"),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              return validatorPhone(val.toString());
                            },
                          ),
                          const SizedBox(height: 10.0),

                          const SizedBox(height: 10.0),
                          Container(
                            child: Obx(() => TextFormField(
                              controller: logic.password,
                              validator: (v) {
                                return validatorPassword(
                                    v.toString(), 6);
                              },
                              obscureText: logic.isHide.value,
                              decoration: InputDecoration(
                                  labelText: "Mật khẩu",
                                  hintText: "Nhập mật khẩu",
                                  suffixIcon: IconButton(
                                    icon: logic.isHide.value
                                        ? const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                    )
                                        : const Icon(
                                      Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      logic.isHide.value =
                                      !logic.isHide.value;
                                    },
                                  )),
                            )),
                          ),
                          const SizedBox(height: 17.5),
                          Container(
                            child: Obx(() => TextFormField(
                              controller: logic.cfPassword,
                              validator: (v) {
                                return validatorPassword(
                                    v.toString(), 6);
                              },
                              obscureText: logic.isHideConfirm.value,
                              decoration: InputDecoration(
                                  labelText: "Nhập lại mật khẩu ",
                                  hintText: "Nhập lại mật khẩu của bạn",
                                  suffixIcon: IconButton(
                                    icon: logic.isHideConfirm.value
                                        ? const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                    )
                                        : const Icon(
                                      Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      logic.isHideConfirm.value =
                                      !logic.isHideConfirm.value;
                                    },
                                  )),
                            )),
                          ),

                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            child: const Text(
                              "Tạo Người Dùng ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (logic.keys.currentState!.validate()) {
                                logic.signUpGa();
                              }
                            },
                          ),
                          const SizedBox(height: 25.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
