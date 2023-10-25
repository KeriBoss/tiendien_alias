import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/AuthService.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';

import 'package:tiendien_alias/provider/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  AuthService authService = AuthService();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordNewController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  UserProvider userProvider = UserProvider();

  var formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    LoadData();
  }

  void LoadData() async {
    currentUser.value = await getCurrentUser();
    emailController =
        TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
  }

  Future<UserModel?> getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (FirebaseAuth.instance.currentUser != null) {
      final usersRef = FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (users, _) => users.toJson(),
          );
      if (auth.currentUser != null) {
        UserModel userModel = await usersRef
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) => value.data()!);
        return userModel;
      }
    }
    return null;
  }

  void changePassword(BuildContext context) async {
    authService.changePassword(passwordController.text.trim(),
        passwordNewController.text.trim(), context);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'password': passwordNewController.text.trim()});
  }
}
