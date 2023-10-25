import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/historyPayment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThongKeBuyController extends GetxController {
  RxList<HistoryPayment> listHistory = RxList();
  List<HistoryPayment> listTemp = [];
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
    await FirebaseFirestore.instance
        .collection('historyPayment')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listTemp = value.docs
            .map((e) => HistoryPayment.fromJson(e.data()))
            .toList()
            .where((element) => element.listElectricityBill
                .where((element) => element.isPayment == true)
                .isNotEmpty)
            .toList();
        listTemp.sort(
          (a, b) => b.createdDate.compareTo(a.createdDate),
        );
        totalPrice.value = calculateTotalPayment(listTemp);
        listHistory.value = listTemp;
        listHistory.refresh();
      }
    });
  }

  num calculateTotalPayment(List<HistoryPayment> historyPayments) {
    num totalPayment = 00;

    for (var historyPayment in historyPayments) {
      for (var electricityBill in historyPayment.listElectricityBill) {
        if (electricityBill.isPayment == true) {
          totalPayment += electricityBill.priceBill;
        }
      }
    }

    return totalPayment;
  }

  sortTime() {
    totalPrice.value = 0;
    listHistory.value = listTemp
        .where((element) =>
            element.createdDate.isAfter(startDate!) &&
            element.createdDate.isBefore(endDate!))
        .toList();
    totalPrice.value = calculateTotalPayment(listHistory);
  }
}
