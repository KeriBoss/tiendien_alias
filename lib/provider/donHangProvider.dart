import 'dart:convert';

import 'package:tiendien_alias/models/cart_item.dart';
import 'package:tiendien_alias/models/dichVu.dart';
import 'package:tiendien_alias/models/donHang.dart';
import 'package:tiendien_alias/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import '../Sevice/RealTimeDatabaseService.dart';

//const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class DonHangProvider {
  RealTimeDatabaseService database = RealTimeDatabaseService();

  Future datHang(DonHangModel donHangModel) async {
    var uuid = Uuid();

    await RealTimeDatabaseService.ref
        .child('donHang')
        .child(donHangModel.id)
        .set(donHangModel.toJson());
  }

  Future giaoTho(String id, DonHangModel donHangModel) async {
    donHangModel.idTho = id;
    donHangModel.trangThai = "Đã giao nhân viên";
    await RealTimeDatabaseService.ref
        .child('donHang')
        .child(donHangModel.id)
        .set(donHangModel.toJson());
  }

  Future<DonHangModel?> getDonHang(String id) async {
    final snapshot =
        await RealTimeDatabaseService.ref.child('donHang').child(id).once();

    Map<String, dynamic> jsonValue =
        json.decode(json.encode(snapshot.snapshot.value));

    return DonHangModel.fromJson(jsonValue);
  }

  Future<List<DonHangModel>> getAllDonHang() async {
    List<DonHangModel> list = [];
    final classSnapshot =
        await RealTimeDatabaseService.ref.child("donHang").ref.get();
    print(classSnapshot.value);
    classSnapshot.children.forEach((element) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(element.value));
      if (jsonValue["role"] == 2) {
        list.add(DonHangModel.fromJson(jsonValue));
      }
    });
    return list;
  }
}
