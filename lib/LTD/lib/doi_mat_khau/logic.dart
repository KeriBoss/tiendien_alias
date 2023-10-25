import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/DiaLog.dart';
import 'package:tiendien_alias/LTD/lib/Models/Users.dart';
import 'package:tiendien_alias/LTD/lib/Provider.dart';
import 'package:tiendien_alias/LTD/lib/constants/color_constants.dart';

class DoiMatKhauLogic extends GetxController {
  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  Rxn<UserModelLTD> currentUser = Rxn<UserModelLTD>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordNewController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  UserProvider userProvider = UserProvider();

  var formKey = GlobalKey<FormState>();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await LoadData();
    print(currentUser.value!.toJson());
  }

  LoadData() async {
    currentUser.value = await userProvider.getUser();
    emailController =
        TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
  }

  void ChangePassword(BuildContext context) async {
    print(passwordController.text);
    print(currentUser.value!.role);
    print(currentUser.value!.email);
    print(currentUser.toJson());
    try {
      DiaLog.showIndicatorDialog();
      await FirebaseAuth.instance.currentUser!
          .updatePassword(passwordNewController.text);
      Get.snackbar("Thông báo", "Đổi mật khẩu thành công",
          snackPosition: SnackPosition.TOP,
          backgroundColor: ColorConstants.primaryColor,
          colorText: Colors.white);
      FirebaseFirestore.instance
          .collection("usersltd")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"password": passwordNewController.text});
      Get.delete();
      Get.close(2);
    } catch (e) {
      Get.close(1);
      print(e.toString());
    }
  }
}
