import 'package:tiendien_alias/models/nhanvien.dart';
import 'package:tiendien_alias/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTimeDatabaseService {
  static final ref = FirebaseDatabase.instance.ref();
  static final currentUser = FirebaseAuth.instance.currentUser;
  Future setUserbyID(UserModel user) async {
    final snapshot = await RealTimeDatabaseService.ref
        .child('user/' + user.id)
        .set(user.toJson());
  }

  Future setNhanVienbyID(NhanVien user) async {
    final snapshot = await RealTimeDatabaseService.ref
        .child('user/' + user.id)
        .set(user.toJson());
  }
}
