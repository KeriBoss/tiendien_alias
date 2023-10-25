import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/color_constants.dart';
import '../../widgets/screen_top.dart';
import 'forgot_passowrd_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          ScreenTop('back'),
          Container(
            margin: EdgeInsets.all(4.55.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text(
                    'Quên Mật Khẩu',
                    style: TextStyles.defaultStyle.medium.setTextSize(35),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: 80.w,
                  child: Text(
                    'Đừng lo lắng, Hãy điền Số điện thoại chúng tôi sẽ gửi lại cho bạn phương thức khôi phục mật khẩu',
                    style: TextStyles.defaultStyle.medium,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Form(
                  key: forgotPasswordController.formKey,
                  child: TextFormField(
                    controller: forgotPasswordController.phoneController,
                    decoration: InputDecoration(
                        hintText: 'Số điện thoại',
                        hintStyle: TextStyles.defaultStyle.medium),
                    validator: (value) => validatorPhoneNumber(value!),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.blackColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(37)),
                    ),
                    onPressed: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      if (forgotPasswordController.formKey.currentState!
                          .validate()) {
                        forgotPasswordController.sendPhone(context);
                      }
                    },
                    child: Text(
                      'Gửi',
                      style: TextStyles.defaultStyle.whiteTextColor.medium,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
