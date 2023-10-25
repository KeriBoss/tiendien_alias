import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/constants/color_palette.dart';
import 'package:tiendien_alias/LTD/lib/constants/textstyle_ext.dart';
import 'package:tiendien_alias/LTD/lib/validate/validate.dart';

import 'logic.dart';

class QuenMatKhauPage extends StatelessWidget {
  QuenMatKhauPage({Key? key}) : super(key: key);

  final forgotController = Get.put(QuenMatKhauLogic());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Quên mật khẩu"),
          automaticallyImplyLeading: true,
          leading: IconButton(
            splashColor: Colors.transparent,
            icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.white,),
            onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 20,),
                      Text("Quên mật khẩu?",
                          style: TextStyles.defaultStyle.setTextSize(32).bold.setColor(ColorPalette.blackColor)
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Vui lòng nhập Email được liên kết với tài khoản của bạn và chúng tôi sẽ gửi cho bạn một liên kết đến nó cùng với hướng dẫn để đặt lại mật khẩu của bạn.",
                        style: TextStyles.defaultStyle.setTextSize(16).setColor(ColorPalette.blackColor),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),

                  SizedBox(
                    width: double.infinity,
                    child: Form(
                      key: forgotController.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: forgotController.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyles.defaultStyle.setColor(ColorPalette.blackColor)
                            ),
                            validator: (value) => validatorEmail(value!),
                          ),

                          const SizedBox(height: 20,),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorPalette.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )
                            ),
                            child: Text(
                              "Gửi",
                              style: TextStyles.defaultStyle.bold.setTextSize(20).setColor(ColorPalette.whiteColor),

                            ),
                            onPressed: () {
                              forgotController.forgotPassword();
                            },
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}