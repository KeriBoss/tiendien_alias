import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Firebase/Firebase_Auth.dart';

class LoginLogic extends GetxController {
  var email = TextEditingController();
  var password = TextEditingController();
  var key = GlobalKey<FormState>();
  FirebaseAuthen _firebaseAuthen = FirebaseAuthen();

  void Login (BuildContext context){
    _firebaseAuthen.signIn(email.text.trim(), password.text.trim(), context);
  }
}
