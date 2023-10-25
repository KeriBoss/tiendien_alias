import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:tiendien_alias/provider/billProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  RxList<BillModel> listBill = RxList();
  List<BillModel> listTemp = [];
  BillProvider billProvider = BillProvider();
  HomeCustomerController homeCustomerController = Get.find();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    await onChange();
  }

  Future<void> getAllMyBill() async {
    listTemp = await billProvider.getAllBill(Status.choMuaBill);
    listTemp.sort(
      (a, b) => b.dateBill.compareTo(a.dateBill),
    );
    listBill.value = listTemp;
    listBill.refresh();
  }

  onChange() async {
    FirebaseFirestore.instance
        .collection('bill')
        .where('status', isEqualTo: Status.choMuaBill.name)
        .snapshots()
        .listen((event) async {
      await getAllMyBill();
    });
  }

  String formatMoney(num money) {
    if (money >= 1000000) {
      num millions = money / 1000000;
      return '${millions.toStringAsFixed(1)}tr';
    } else {
      num millions = money / 1000;
      return '${millions.toStringAsFixed(0)}k';
    }
  }

  searchView(String query) {
    if (query != '') {
      listBill.value = listTemp
          .where((element) =>
              element.username.toLowerCase().contains(query.toLowerCase()) ||
              element.discountBill
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    } else {
      listBill.value = listTemp;
    }
  }
}
