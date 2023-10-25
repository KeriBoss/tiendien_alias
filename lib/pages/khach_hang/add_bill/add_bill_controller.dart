import 'dart:math';

import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/electricityBill.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/khach_hang/add_bill/choose_fee/choose_fee_page.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddBillController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  List<String> listTypeBill = ['PA', 'PB', 'PC', 'PD', 'PE'];
  RxInt selectedItemIndex = RxInt(-1);
  HomeCustomerController homeCustomerController = Get.find();

  final formKey = GlobalKey<FormState>();
  var codeBillController = TextEditingController();

  List<String> listBill = [];
  List<BillModel> listBillModel = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    selectedItemIndex.value = 0;
  }

  checkBillApi() async {
    if (codeBillController.text != "") {
      listBill = codeBillController.text.split('\n');
      print(listBill.first);
    }
  }

  addBill() {
    DiaLog.showIndicatorDialog();
    List<BillModel> listTemp = [];
    listBill = codeBillController.text.split('\n');
    for (int i = 1; i <= listBill.length; i += 10) {
      int endIndex = i + 10 - 1;
      if (endIndex > listBill.length) {
        endIndex = listBill.length;
      }

      List<int> group = List.generate(endIndex - i + 1, (index) => i + index);
      List<ElectricityBillModel> listElectricityBill = [];
      num priceBill = 0;
      for (var item in group) {
        ElectricityBillModel electricityBillModel = ElectricityBillModel(
          codeBill: listBill[item - 1],
          username: 'Trung',
          priceBill: 500000,
          address: 'Khong co',
          isCheck: false,
          isPayment: false,
        );
        priceBill += electricityBillModel.priceBill;
        listElectricityBill.add(electricityBillModel);
      }

      BillModel billModel = BillModel(
          id: listBill[i - 1],
          listBill: listElectricityBill,
          listBillPaid: [],
          priceBill: priceBill,
          totalBill: priceBill,
          price: priceBill,
          discountBill: 0,
          dateBill: DateTime.now(),
          username: homeCustomerController.currentUser.value!.name,
          gender: homeCustomerController.currentUser.value!.gender,
          byUser: FirebaseAuth.instance.currentUser!.uid,
          userBuy: '',
          status: Status.choMuaBill,
          isPayment: false);
      listTemp.add(billModel);
    }

    listBillModel = listTemp;
    Get.close(2);
    Get.to(() => ChooseFeePage(), arguments: listBillModel);
  }
}
