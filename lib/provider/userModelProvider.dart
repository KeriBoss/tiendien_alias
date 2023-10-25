import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModelProvider {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<UserModel?> getCurrentUser() async {
    UserModel? userModel;
    if (auth.currentUser != null) {
      final usersRef =
          firebaseFirestore.collection('users').withConverter<UserModel>(
                fromFirestore: (snapshot, _) =>
                    UserModel.fromJson(snapshot.data()!),
                toFirestore: (users, _) => users.toJson(),
              );
      if (auth.currentUser != null) {
        userModel = await usersRef
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) => value.data()!);
      }
    }
    return userModel;
  }

  Future<UserModel> getUserById(String id) async {
    final usersRef = firebaseFirestore
        .collection('users')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (users, _) => users.toJson(),
        );
    UserModel userModel =
        await usersRef.doc(id).get().then((value) => value.data()!);
    return userModel;
  }
}
