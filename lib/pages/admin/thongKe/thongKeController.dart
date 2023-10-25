import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:tiendien_alias/Sevice/RealTimeDatabaseService.dart';
import 'package:tiendien_alias/models/donHang.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/hoaDon.dart';
import 'package:get/get.dart';

class ThongKeController extends GetxController {
  RxList<DonHangModel> listDonHang = RxList<DonHangModel>();
  RxList<GiaoDichModel> listGiaoDichNap = RxList<GiaoDichModel>();
  RxList<GiaoDichModel> listGiaoDichRut = RxList<GiaoDichModel>();
  RxList<HoaDonModel> listHoaDon = RxList<HoaDonModel>();
  RxInt totalHoaDon = RxInt(0);
  RxInt totalDonHang = RxInt(0);
  RxInt totalNap = RxInt(0);
  RxInt totalRut = RxInt(0);

  @override
  void onInit() async {
    // TODO: implement onInit
    await loadDataDonHang();
    await loadDataGiaoDich();
    await loadDataHoaDon();
    print(listHoaDon.length);
    super.onInit();
  }

  loadDataDonHang() async {
    listDonHang.clear();
    totalDonHang.value = 0;
    List<DonHangModel> list = [];
    final snapshot =
        await FirebaseDatabase.instance.ref().child('donHang').get();
    for (var item in snapshot.children) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(item.value));
      DonHangModel donHang = DonHangModel.fromJson(jsonValue);
      list.add(donHang);
      list.sort((a, b) => b.ngayTao.compareTo(a.ngayTao));
    }
    listDonHang.value = list;
    for (var item in list) {
      totalDonHang.value += int.parse(item.dichVu.gia) * 10;
    }
    listDonHang.refresh();
    totalDonHang.refresh();
  }

  loadDataGiaoDich() async {
    listGiaoDichNap.clear();
    listGiaoDichRut.clear();
    totalNap.value = 0;
    totalRut.value = 0;
    List<GiaoDichModel> list = [];
    final snapshot =
        await FirebaseDatabase.instance.ref().child("napTien").get();
    for (var item in snapshot.children) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(item.value));
      GiaoDichModel giaoDich = GiaoDichModel.fromJson(jsonValue);
      list.add(giaoDich);
      list.sort((a, b) => b.time.compareTo(a.time));
    }
    listGiaoDichNap.value = list
        .where((element) =>
            element.loaiGiaoDich == LoaiGiaoDich.napTien &&
            element.trangThai == "Hoàn thành")
        .toList();
    listGiaoDichRut.value = list
        .where((element) =>
            element.loaiGiaoDich == LoaiGiaoDich.rutTien &&
            element.trangThai == "Đã hoàn thành")
        .toList();
    ;
    for (var item in list) {
      if (item.loaiGiaoDich == LoaiGiaoDich.napTien &&
          item.trangThai == "Hoàn thành") {
        totalNap.value += int.parse(item.soTien);
      }
    }
    for (var item in list) {
      if (item.loaiGiaoDich == LoaiGiaoDich.rutTien &&
          item.trangThai == "Đã hoàn thành") {
        totalRut.value += int.parse(item.soTien);
      }
    }

    listGiaoDichNap.refresh();
    listGiaoDichRut.refresh();
    totalNap.refresh();
    totalRut.refresh();
  }

  loadDataHoaDon() async {
    listHoaDon.clear();
    totalHoaDon.value = 0;
    List<HoaDonModel> list = [];
    final classSnapshot =
        await FirebaseDatabase.instance.ref().child('hoaDon').get();
    for (var item in classSnapshot.children) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(item.value));
      HoaDonModel hoaDon = HoaDonModel.fromJson(jsonValue);
      list.add(hoaDon);
      list.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    }
    listHoaDon.value = list;
    for (var item in list) {
      totalHoaDon.value += int.parse(item.donHang.dichVu.gia);
    }
    listHoaDon.refresh();
    totalHoaDon.refresh();
  }
}
