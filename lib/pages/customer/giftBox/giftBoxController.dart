import 'dart:convert';

import 'package:tiendien_alias/Sevice/RealTimeDatabaseService.dart';
import 'package:tiendien_alias/models/donHang.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GiftBoxController extends GetxController {
  RxList<DonHangModel> listDonHang = RxList<DonHangModel>();

  @override
  void onInit() {
    // TODO: implement onInit
    loadData();
    onChangeValue();
    super.onInit();
  }

  loadData() async {
    listDonHang.clear();
    List<DonHangModel> list = [];
    final snapshot = await RealTimeDatabaseService.ref
        .child('donHang')
        .orderByChild('idKhach')
        .equalTo(FirebaseAuth.instance.currentUser!.uid)
        .get();
    for (var item in snapshot.children) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(item.value));
      DonHangModel donHang = DonHangModel.fromJson(jsonValue);
      list.add(donHang);
      list.sort((a, b) => b.ngayTao.compareTo(a.ngayTao));
    }
    listDonHang.value = list;
    listDonHang.refresh();
    print(listDonHang.length);
  }

  onChangeValue() async {
    await RealTimeDatabaseService.ref
        .child('donHang/${FirebaseAuth.instance.currentUser!.uid}')
        .onValue
        .listen((event) {
      loadData();
    });
  }
}
