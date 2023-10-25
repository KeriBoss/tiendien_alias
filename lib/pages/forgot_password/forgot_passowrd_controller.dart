import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/forgot_password/update_password/update_password_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ForgotPasswordController extends GetxController {
  var phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  sendPhone(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('phone', isEqualTo: phoneController.text)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        UserModel userModel = UserModel.fromJson(value.docs.first.data());
        Get.to(() => UpdatePasswordPage(),
            arguments: [userModel.email, userModel.password]);
      } else {
        // handle not find phone
        openDiaLogError(context, 'Số điện thoại không tồn tại');
      }
    });
  }

  void openDiaLogError(BuildContext context, String hintText) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            decoration: BoxDecoration(
              color: ColorPalette.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/png/ic_sad.png',
                  width: 64,
                  height: 64,
                ),
                const SizedBox(
                  height: 11,
                ),
                Text(
                  "$hintText!",
                  style: TextStyles.defaultStyle.medium
                      .setColor(ColorPalette.errorColor),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Get.close(1);
                  },
                  child: Container(
                    width: 130,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: ColorPalette.blackColor,
                    ),
                    child: Center(
                        child: Text(
                      'Xong',
                      style: TextStyles.defaultStyle.medium.whiteTextColor,
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
