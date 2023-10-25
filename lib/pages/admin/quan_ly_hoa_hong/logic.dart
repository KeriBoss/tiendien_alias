import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/HoaHong.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuanLyHoaHongLogic extends GetxController {
  var soTienNguoiNhan = TextEditingController();
  var soTienNguoiMoi = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('hoaHong');
  var key = GlobalKey<FormState>();
  Rxn<HoaHong> hoaHongNguoiNhan = Rxn<HoaHong>();
  Rxn<HoaHong> hoaHongNguoiMoi = Rxn<HoaHong>();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadData();
  }

  Future<void> loadData() async {
    await ref.doc("hoaHongNguoiNhan").get().then((value) {
      hoaHongNguoiNhan.value = HoaHong.fromJson(value.data()!);
      if (hoaHongNguoiNhan.value != null) {
        soTienNguoiNhan = TextEditingController(
            text: hoaHongNguoiNhan.value!.soTienNhan.toInt().toString());
      }
    });
    await ref.doc("hoaHongNguoiMoi").get().then((value) {
      hoaHongNguoiMoi.value = HoaHong.fromJson(value.data()!);
      if (hoaHongNguoiMoi.value != null) {
        soTienNguoiMoi = TextEditingController(
            text: hoaHongNguoiMoi.value!.soTienNhan.toInt().toString());
      }
    });
  }

  void addHoaHong() {
    HoaHong hoaHongNguoiNhan =
        HoaHong("hoaHongNguoiNhan", double.parse(soTienNguoiNhan.text));
    HoaHong hoaHongNguoiMoi =
        HoaHong("hoaHongNguoiMoi", double.parse(soTienNguoiMoi.text));
    ref.doc("hoaHongNguoiNhan").set(hoaHongNguoiNhan.toJson());
    ref.doc("hoaHongNguoiMoi").set(hoaHongNguoiMoi.toJson());
    Get.snackbar("Thông báo", "Cập nhật thành công!!",
        backgroundColor: Colors.white);
  }
}
