import 'dart:convert';

import 'package:tiendien_alias/Sevice/RealTimeDatabaseService.dart';
import 'package:tiendien_alias/models/dichVu.dart';
import 'package:tiendien_alias/models/dichVuMain.dart';
import 'package:tiendien_alias/models/dichVuSub.dart';
import 'package:tiendien_alias/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DichVuProvider {
  RealTimeDatabaseService database = RealTimeDatabaseService();

  Future<List<DichVuSub>> getAllDichVuSub() async {
    List<DichVuSub> list = [];
    final classSnapshot =
        await RealTimeDatabaseService.ref.child("dichVuSub").ref.get();
    print(classSnapshot.value);
    classSnapshot.children.forEach((element) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(element.value));

      list.add(DichVuSub.fromJson(jsonValue));
    });
    return list;
  }

  Future<DichVuSub> getDichVuSubByID(String id) async {
    final classSnapshot = await RealTimeDatabaseService.ref
        .child("dichVuSub")
        .child(id)
        .ref
        .get();
    print(classSnapshot.value);

    Map<String, dynamic> jsonValue =
        json.decode(json.encode(classSnapshot.value));

    return DichVuSub.fromJson(jsonValue);
  }

  Future<DichVuMain> getDichVuMainByID(String id) async {
    final classSnapshot = await RealTimeDatabaseService.ref
        .child("dichVuMain")
        .child(id)
        .ref
        .get();
    print(classSnapshot.value);

    Map<String, dynamic> jsonValue =
        json.decode(json.encode(classSnapshot.value));

    return DichVuMain.fromJson(jsonValue);
  }

  Future<List<DichVuSub>> getDichVuSub(String idCha) async {
    List<DichVuSub> list = [];

    final classSnapshot =
        await RealTimeDatabaseService.ref.child("dichVuSub").ref.get();
    print(classSnapshot.value);
    classSnapshot.children.forEach((element) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(element.value));
      if (jsonValue["idMain"] == idCha) {
        list.add(DichVuSub.fromJson(jsonValue));
      }
    });
    print("sub" + list.length.toString());
    return list;
  }

  Future<List<DichVu>> getDichVu(String idCha) async {
    List<DichVu> list = [];

    final classSnapshot =
        await RealTimeDatabaseService.ref.child("dichVu").ref.get();

    classSnapshot.children.forEach((element) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(element.value));
      if (jsonValue["idDichVuCha"] == idCha) {
        list.add(DichVu.fromJson(jsonValue));
        print(idCha);
      }
    });
    return list;
  }

  Future setDichVu(DichVu dichVu) async {
    final snapshot = await RealTimeDatabaseService.ref
        .child('dichVu/' + dichVu.id)
        .set(dichVu.toJson());
  }

  Future setDichVuSub(DichVuSub dichVu) async {
    final snapshot = await RealTimeDatabaseService.ref
        .child('dichVuSub/' + dichVu.id)
        .set(dichVu.toJson());
  }

  Future deleteDichVu(DichVu dichVu) async {
    final snapshot =
        await RealTimeDatabaseService.ref.child('dichVu/' + dichVu.id).remove();
  }

  Future deleteDichVuSub(DichVuSub dichVu) async {
    final snapshot = await RealTimeDatabaseService.ref
        .child('dichVuSub/' + dichVu.id)
        .remove();
  }
}
