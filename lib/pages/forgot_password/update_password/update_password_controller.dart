import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  String email = Get.arguments[0];
  String password = Get.arguments[1];
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool isCheck1 = RxBool(false);
  RxBool isCheck2 = RxBool(true);
  RxBool isCheck3 = RxBool(true);

  Future changePassword(String newPassword) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      try {
        DiaLog.showIndicatorDialog();
        userCredential.user!.updatePassword(newPassword).then((_) async {
          Get.close(1);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .update({'password': newPassword}).whenComplete(() async {
            await FirebaseAuth.instance.signOut();
            openDiaLogSuccess(Get.context!);
          });
        }).catchError((error) {
          // This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
          Get.close(1);
          openDiaLogError(Get.context!, error.toString());
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.close(1);
          openDiaLogError(Get.context!, 'Không tìm thấy tài khoản');
        } else if (e.code == 'wrong-password') {
          Get.close(1);
          openDiaLogError(Get.context!, 'Sai mật khẩu');
        }
      }
    }
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

  void openDiaLogSuccess(BuildContext context) {
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
                  'assets/png/ic_success_2.png',
                  width: 64,
                  height: 64,
                ),
                const SizedBox(
                  height: 11,
                ),
                Text(
                  "Đổi mật khẩu thành công!",
                  style: TextStyles.defaultStyle.medium,
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offNamed('/welcome');
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
