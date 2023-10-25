// import 'dart:math';
//
// import 'package:tiendien_alias/constants/color_palette.dart';
// import 'package:tiendien_alias/constants/font_constants.dart';
// import 'package:tiendien_alias/constants/textstyle_ext.dart';
// import 'package:tiendien_alias/pages/login/login_controller.dart';
// import 'package:tiendien_alias/pages/policy/policyPage.dart';
// import 'package:tiendien_alias/pages/resgister/resgisterPage.dart';
// import 'package:tiendien_alias/pages/scan_qr/scan_qrPage.dart';
// import 'package:tiendien_alias/widgets/screen_top.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../constants/color_constants.dart';
//
// class LoginScreen extends StatelessWidget {
//   LoginScreen({Key? key}) : super(key: key);
//
//   LoginController loginController = Get.put(LoginController());
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
//         child: Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: SingleChildScrollView(
//               child: Column(children: [
//                 //ScreenTop('Sign in'),
//                 const SizedBox(height: 20,),
//                 Image.asset("assets/pngs/logoPhoenix.png", height: 200,
//                   fit: BoxFit.fitHeight,),
//                 Text("Đăng nhập để trải nghiệm \nứng dụng",
//                   style: TextStyles.defaultStyle.bold.setTextSize(23).setColor(
//                       ColorPalette.primaryColor),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(
//                   height: 3.h,
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 4.5.w),
//                   child: Column(
//                     children: [
//                       TextField(
//                         decoration: const InputDecoration(label: Text('Email')),
//                         controller: loginController.emailController,
//                       ),
//                       SizedBox(
//                         height: 3.5.h,
//                       ),
//                       Obx(() =>
//                           TextField(
//                             controller: loginController.passwordController,
//                             decoration: InputDecoration(
//                                 label: const Text(
//                                   'Mật khẩu',
//                                 ),
//                                 suffixIcon: IconButton(
//                                   icon: loginController.isHide.value
//                                       ? const Icon(
//                                     Icons.remove_red_eye,
//                                     color: Colors.black,
//                                   )
//                                       : const Icon(
//                                     Icons.visibility_off,
//                                     color: Colors.black,
//                                   ),
//                                   onPressed: () {
//                                     loginController.isHide.value =
//                                     !loginController.isHide.value;
//                                   },
//                                 )),
//                             obscureText: loginController.isHide.value,
//                           )),
//                       SizedBox(
//                         height: 2.h,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           TextButton(
//                             onPressed: () => Get.toNamed("/forgotpassword"),
//                             child: Text(
//                               'Quên mật khẩu ?',
//                               style: Theme
//                                   .of(context)
//                                   .textTheme
//                                   .headline5,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 2.5.h,
//                       ),
//
//                       ElevatedButton(
//                           onPressed: () {
//                             loginController.loginValidate(context);
//                           },
//                           child: const Text(
//                             'Đăng nhập',
//                             style: TextStyle(color: ColorConstants.whiteColor),
//                           )),
//                       Padding(
//                         padding: EdgeInsets.only(
//                           top: 2.h,
//                           bottom: 2.h,
//                         ),
//                         child: Text(
//                           'Hoặc ',
//                           style: Theme
//                               .of(context)
//                               .textTheme
//                               .headlineSmall,
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             'Bạn chưa có tài khoản ? ',
//                             style: TextStyle(
//                               fontFamily: FontConstants.comfortaaBold,
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               //Get.toNamed("/signup");
//                               //Get.to(() => RegisterPage());
//                               Get.to(() => ScanQrPage());
//                             },
//                             child: Text(' Đăng ký',
//                                 style: TextStyles.defaultStyle
//                                     .setColor(ColorPalette.primaryColor)
//                                     .semiBold
//                                     .setTextSize(18)
//                             ),
//                           )
//                         ],
//                       ),
//
//
//                     ],
//                   ),
//                 ),
//               ]),
//             )));
//   }
// }
