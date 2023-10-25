import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/customer.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpCustomerController extends GetxController {
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var cccdController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isShow = RxBool(false);

  void signUpCustomer(BuildContext context) async {
    String email =
        "${DateTime.now().toString().replaceAll(RegExp('[^a-zA-Z0-9]'), '')}@gmail.com";
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    await FirebaseFirestore.instance
        .collection('phone')
        .where('phone', isEqualTo: phone)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        DiaLog.showIndicatorDialog();
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          CustomerModel customerModel = CustomerModel(
              id: user.uid,
              email: email,
              name: nameController.text.trim(),
              phone: phone,
              cccd: cccdController.text.trim(),
              password: password,
              avatar: '',
              isShow: isShow.value);
          await DatabaseProvider()
              .addModel(
                  collection: 'customer',
                  id: customerModel.id,
                  toJsonModel: customerModel.toJson())
              .whenComplete(() {
            Get.close(2);
            Get.snackbar(
              'Thông báo',
              'Đăng ký thành công',
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );
          });
        }
      } else {
        openDiaLogError(context, 'Số điện thoại đã tồn tại');
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
