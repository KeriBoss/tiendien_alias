import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThongKeSellController extends GetxController {
  RxList<BillModel> listBill = RxList();
  List<BillModel> listTemp = [];
  RxNum totalPrice = RxNum(0);
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getBill();
  }

  Future<void> getBill() async {
    totalPrice.value = 0;
    await FirebaseFirestore.instance.collection('bill').get().then((value) {
      if (value.docs.isNotEmpty) {
        listTemp = value.docs.map((e) => BillModel.fromJson(e.data())).toList();
        listTemp.sort(
          (a, b) => b.dateBill.compareTo(a.dateBill),
        );
        for (var item in listTemp) {
          totalPrice.value += item.price;
        }
        listBill.value = listTemp;
        listBill.refresh();
      }
    });
  }

  sortTime() {
    totalPrice.value = 0;
    listBill.value = listTemp
        .where((element) =>
            element.dateBill.isAfter(startDate!) &&
            element.dateBill.isBefore(endDate!))
        .toList();
    for (var item in listBill) {
      totalPrice.value += item.price;
    }
  }
}
