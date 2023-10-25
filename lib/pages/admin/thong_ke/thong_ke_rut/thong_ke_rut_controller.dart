import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ThongKeRutController extends GetxController {
  RxList<GiaoDichModel> listNapTien = RxList();
  List<GiaoDichModel> listTemp = [];

  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  RxNum totalPrice = RxNum(0);

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getNapTien();
  }

  Future<void> getNapTien() async {
    totalPrice.value = 0;
    await FirebaseFirestore.instance
        .collection('napTien')
        .where('loaiGiaoDich', isEqualTo: LoaiGiaoDich.rutTien.name)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listTemp =
            value.docs.map((e) => GiaoDichModel.fromJson(e.data())).toList();
        listTemp.sort((a, b) => b.time.compareTo(a.time));
        for (var item in listTemp) {
          totalPrice.value += num.parse(item.soTien);
        }

        listNapTien.value = listTemp;
        listNapTien.refresh();
      }
    });
  }

  void sortTime() {
    totalPrice.value = 0;
    listNapTien.value = listTemp
        .where((element) =>
            element.time.isAfter(startDate!) && element.time.isBefore(endDate!))
        .toList();
    for (var item in listNapTien) {
      totalPrice.value += num.parse(item.soTien);
    }
  }
}
