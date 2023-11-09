import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiendien_alias/LTD/lib/Page/Splash.dart';

import '../Models/Users.dart';

class FirebaseAuthen {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //FirebaseAuthen();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign in
  Future<void> signIn(
      String email, String password, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString("password", password);
    try {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                alignment: FractionalOffset.center,
                height: 150.0,
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Loading",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          });
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _firebaseFirestore
            .collection("usersltd")
            .doc(_firebaseAuth.currentUser!.uid)
            .get()
            .then((value) async {
          final fcmToken = await FirebaseMessaging.instance.getToken();
          _firebaseFirestore
              .collection("usersltd")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'toKen': fcmToken});
          Get.to(() => SplashPageLTD());
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.close(1);
        Get.snackbar("Thông báo", "Email chưa đăng ký",
            backgroundColor: Colors.red);
      } else if (e.code == 'wrong-password') {
        Get.close(1);
        Get.snackbar("Thông báo", "Sai mật khẩu", backgroundColor: Colors.red);
      }
    }
  }

  // Sign up
  Future<void> signUp(String email, String password, String username,
      String address, String phone, BuildContext context) async {
    try {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                alignment: FractionalOffset.center,
                height: 150.0,
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Loading",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          });
      print(email);
      print(password);
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      User? user = _firebaseAuth.currentUser;
      UserModelLTD userModel = UserModelLTD(user!.uid, username, email, address,
          "", "", phone, 1, DateTime.now(), "");
      await _firebaseFirestore
          .collection('usersltd')
          .doc(userModel.id)
          .set(userModel.toJson())
          .then((v) {
        Get.close(0);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.close(1);
        Get.snackbar("Thông báo", "Email đã tồn tại trên hệ thống");
      }
    }
  }

  // SignOut
  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    Get.offAllNamed("/loginltd");
  }

  Future<void> passwordRest(String email, BuildContext context) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text(
                "Thông báo",
                style: TextStyle(color: Colors.blue),
              ),
              content: Text(
                  "Link lấy đổi mật khẩu đã được gửi, Vui lòng kiểm tra email"),
            );
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Thông báo", "Email chưa đăng ký");
      } else {
        print(e.toString());
      }
    }
  }

  void getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update({
      "token": token,
    });
  }

  void deleteToken() async {
    String? token = "";
    await _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update({
      "token": token,
    });
  }
}
