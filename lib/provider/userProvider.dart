import 'dart:convert';

import 'package:tiendien_alias/models/dichVu.dart';
import 'package:tiendien_alias/models/nhanvien.dart';
import 'package:tiendien_alias/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Sevice/RealTimeDatabaseService.dart';

//const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class UserProvider {
  RealTimeDatabaseService database = RealTimeDatabaseService();

  Future<UserModel?> getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (FirebaseAuth.instance.currentUser != null) {
      final snapshot = await FirebaseDatabase.instance
          .ref()
          .child('user')
          .child(auth.currentUser!.uid.toString())
          .once();
      Map<String, dynamic> jsonValue =
          json.decode(json.encode(snapshot.snapshot.value));
      if (jsonValue != null) {
        if (jsonValue.isNotEmpty) {
          print(jsonValue);
          return UserModel.fromJson(jsonValue);
        }
      }
    }
    return null;
  }

  Future<NhanVien?> getNhanVien() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final snapshot = await RealTimeDatabaseService.ref
          .child('user/' + FirebaseAuth.instance.currentUser!.uid)
          .once();
      String jsonsDataString = snapshot.snapshot.value.toString();
      Map<String, dynamic> jsonValue =
          json.decode(json.encode(snapshot.snapshot.value));

      print(jsonValue["idDichVuMain"]);
      return NhanVien.fromJson(jsonValue);
    }
    return null;
  }

  Future<NhanVien?> getNhanVienByID(String id) async {
    if (id != "") {
      final snapshot =
          await RealTimeDatabaseService.ref.child('user/' + id).once();
      String jsonsDataString = snapshot.snapshot.value.toString();
      Map<String, dynamic> jsonValue =
          json.decode(json.encode(snapshot.snapshot.value));
      print(jsonsDataString);
      return NhanVien.fromJson(jsonValue);
    }
    return null;
  }

  Future<UserModel> getUserByID(String id) async {
    final snapshot =
        await RealTimeDatabaseService.ref.child('user/' + id).once();
    String jsonsDataString = snapshot.snapshot.value.toString();
    Map<String, dynamic> jsonValue =
        json.decode(json.encode(snapshot.snapshot.value));

    return UserModel.fromJson(jsonValue);
  }

  Future<List<UserModel>> getUserByRole(int role) async {
    List<UserModel> list = [];
    final classSnapshot =
        await RealTimeDatabaseService.ref.child("user").ref.get();
    print(classSnapshot.value);
    classSnapshot.children.forEach((element) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(element.value));
      if (jsonValue["role"] == role) {
        list.add(UserModel.fromJson(jsonValue));
      }
    });
    return list;
  }

  Future<List<UserModel>> getUserByRoleByNganh(int role, DichVu dichVu) async {
    List<UserModel> list = [];
    final classSnapshot =
        await RealTimeDatabaseService.ref.child("user").ref.get();
    print(classSnapshot.value);
    classSnapshot.children.forEach((element) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(element.value));
      if (jsonValue["role"] == role &&
          jsonValue["idDichVuMain"] == dichVu.idDichVuMain &&
          jsonValue["status"] == "Đang hoạt động") {
        list.add(UserModel.fromJson(jsonValue));
      }
    });
    return list;
  }

  Future<List<UserModel>> getAllParent() async {
    List<UserModel> list = [];

    final classSnapshot =
        await RealTimeDatabaseService.ref.child("user").ref.get();
    print(classSnapshot.value);
    classSnapshot.children.forEach((element) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(element.value));
      if (jsonValue["role"] == 2) {
        list.add(UserModel.fromJson(jsonValue));
      }
    });
    return list;
  }

  Future<List<UserModel>> getAllUser() async {
    List<UserModel> list = [];

    final classSnapshot =
        await RealTimeDatabaseService.ref.child("user").ref.get();
    print(classSnapshot.value);
    classSnapshot.children.forEach((element) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(element.value));

      list.add(UserModel.fromJson(jsonValue));
    });
    return list;
  }

  Future<UserModel> getAdmin() async {
    late UserModel admin;
    final classSnapshot =
        await RealTimeDatabaseService.ref.child("user").ref.get();
    print(classSnapshot.value);
    classSnapshot.children.forEach((element) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(element.value));
      if (jsonValue["role"] == 0) {
        admin = UserModel.fromJson(jsonValue);
      }
    });
    return admin;
  }

  Future<List<UserModel>> getAllTeacher() async {
    List<UserModel> list = [];

    final classSnapshot =
        await RealTimeDatabaseService.ref.child("user").ref.get();
    print(classSnapshot.value);
    classSnapshot.children.forEach((element) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(element.value));
      if (jsonValue["role"] == 1) {
        list.add(UserModel.fromJson(jsonValue));
      }
    });
    return list;
  }

  Future setUser(UserModel user) async {
    final snapshot = await RealTimeDatabaseService.ref
        .child('user/' + user.id)
        .set(user.toJson());
  }

  Future setUserbyID(UserModel user) async {
    final snapshot = await RealTimeDatabaseService.ref
        .child('user/' + user.id)
        .set(user.toJson());
  }
}
