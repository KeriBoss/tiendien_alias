import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Firebase/Firebase_Auth.dart';

class RegisterLogic extends GetxController {
  FirebaseAuthen _firebaseAuthen = FirebaseAuthen();
  var username = TextEditingController();
  var email = TextEditingController();
  var phoneNumber = TextEditingController();
  var address = TextEditingController();
  var password = TextEditingController();
  var cfPassword = TextEditingController();
  var key = GlobalKey<FormState>();

  void SignUp (BuildContext context){
    _firebaseAuthen.signUp(email.text.trim(), password.text.trim(), username.text.trim(),address.text.trim() , phoneNumber.text.trim(), context);
  }
}
