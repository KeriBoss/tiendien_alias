import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/Users.dart';

class UserProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rxn<UserModelLTD> userModel = Rxn();

  Future<UserModelLTD?> getUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser!.uid);
      await firestore
          .collection('usersltd')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        userModel.value = UserModelLTD(
            value['id'],
            value['username'],
            value['email'],
            value['address'],
            value['avatar_image'],
            value['avatar_image_link'],
            value['phone'],
            value['role'],
            value['ngayTao'].toDate(),
            value['toKen']);
      });
    }
    return userModel.value;
  }
  // Future<UserModel?> getUser() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     final snapshot = await firestore
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //     Map<String, dynamic> jsonValue =
  //     json.decode(json.encode(snapshot.data()));
  //     return UserModel.fromJson(jsonValue);
  //   }
  //   return null;
  // }
}
