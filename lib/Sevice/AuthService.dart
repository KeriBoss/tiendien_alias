import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  Future<UserCredential> registerUser(String email, String password) async {
    UserCredential _authResult = await fireAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    return _authResult;
  }

  Future<UserCredential> loginUser(String email, String password) async {
    UserCredential _authResult = await fireAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    return _authResult;
  }

  Future<void> signOutUser() async {
    await fireAuth.signOut();
  }

  Future changePassword(
      String currentPassword, String newPassword, BuildContext context) async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DiaLog.showIndicatorDialog();
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email!,
          password: currentPassword,
        );

        user.updatePassword(newPassword).then((_) async {
          Get.close(1);
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: ((context) {
                return AlertDialog(
                  title: const Text('Thông báo'),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text("Đổi mật khẩu thành công"),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Oke'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }));
          await FirebaseFirestore.instance
              .collection('users')
              .doc(fireAuth.currentUser!.uid)
              .update({'password': newPassword});
        }).catchError((error) {
          Get.close(1);
          showDialog(
              context: context,
              builder: ((context) {
                return const AlertDialog(
                  title: Text('Không thể thay đổi mật khẩu'),
                );
              }));
          //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.close(1);
          showDialog(
              context: context,
              builder: ((context) {
                return const AlertDialog(
                  title: Text('Không tìm thấy tài khoản'),
                );
              }));
        } else if (e.code == 'wrong-password') {
          Get.close(1);
          showDialog(
              context: context,
              builder: ((context) {
                return const AlertDialog(
                  title: Text('Sai mật khẩu'),
                );
              }));
        }
      }
    }
  }

  Future<void> passwordRest(String email, BuildContext context) async {
    try {
      await fireAuth.sendPasswordResetEmail(email: email);
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
}
