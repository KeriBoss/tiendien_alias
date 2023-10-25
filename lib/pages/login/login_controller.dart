// import 'package:tiendien_alias/Sevice/AuthService.dart';
// import 'package:tiendien_alias/Sevice/MessagingService.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tiendien_alias/Sevice/localStorageService.dart';
// import 'package:tiendien_alias/dialog/dialog.dart';
// import 'package:tiendien_alias/models/userModel.dart';
// import 'package:tiendien_alias/pages/main_controller.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../provider/userModelProvider.dart';
//
// class LoginController extends GetxController {
//   final MainController _mainController = Get.put(MainController());
//   var emailController = TextEditingController();
//   AuthService authService = AuthService();
//   MessagingService messagingSevice = MessagingService();
//   Rxn<UserModel> currentUser = Rxn();
//   RxBool isHide = RxBool(true);
//   RxBool isSave = RxBool(false);
//   UserModelProvider userProvider = UserModelProvider();
//   TextEditingController passwordController = TextEditingController();
//   final flowKey = Object();
//
//   @override
//   void onInit() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (FirebaseAuth.instance.currentUser != null) {
//       currentUser.value = await userProvider.getCurrentUser();
//       if (currentUser.value != null) {
//         emailController.text = currentUser.value!.email;
//         print(currentUser.value!.email);
//         String? password = prefs.getString('password');
//         if (password != null) {
//           passwordController.text = password;
//           isSave.value = true;
//         }
//       } else {
//         emailController.text = "";
//         passwordController.text = "";
//       }
//     }
//     messagingSevice.requestPermission();
//     messagingSevice.loadFCM();
//     messagingSevice.listenFCM();
//     super.onInit();
//   }
//
//
//
//
//   savePassword() async {
//     var prefs = await SharedPreferences.getInstance();
//
//     if (isSave.value) {
//       await prefs.setString('password', passwordController.text);
//     }
//   }
//
//   void loginValidate(BuildContext context) async {
//     try {
//       if (emailController.text.isEmpty && passwordController.text.isEmpty) {
//         _mainController.alertDialog(
//             'Nhập Email và mật khẩu để đăng nhập', context);
//       } else if (emailController.text.isEmpty) {
//         _mainController.alertDialog('Bạn chưa nhập email', context);
//       } else if (passwordController.text.isEmpty) {
//         _mainController.alertDialog('Bạn chưa nhập mật khẩu', context);
//       } else if (!emailController.text.isEmail) {
//         _mainController.alertDialog(
//             'Vui lòng nhập đúng định dạng email', context);
//       } else {
//         _mainController.showIndicadorDialog();
//         savePassword();
//         await authService.loginUser(emailController.text, passwordController.text);
//
//         currentUser.value = await userProvider.getCurrentUser();
//         final token = await FirebaseMessaging.instance.getToken();
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .update({'token': token});
//
//         if(currentUser.value!.isBlock == false) {
//           Get.offAndToNamed('/splash');
//         } else {
//           FirebaseAuth.instance.signOut();
//           Get.close(1);
//           Get.snackbar("Thông báo", "Tài khoản của bạn đã bị khóa",
//             colorText: Colors.white,
//             backgroundColor: Colors.red
//           );
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//         Get.back();
//
//         _mainController.alertDialog('Khồng tìm thấy tài khoản', context);
//       } else if (e.code == 'wrong-password') {
//         print('Sai mật khẩu hoặc email');
//         Get.back();
//
//         _mainController.alertDialog('Sai mật khẩu hoặc email', context);
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
// }
