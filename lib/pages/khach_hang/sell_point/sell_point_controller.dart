import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellPointController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var moneyController = TextEditingController();

  List<int> listMoney = [50000, 100000, 200000, 300000, 400000, 500000];
  RxInt selectedItemIndex = RxInt(-1);

  UserModel currentUser = Get.arguments;

  RxList<BankCustomer> listBankCustomer = RxList();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getBankCustomer();
  }

  getBankCustomer() async {
    listBankCustomer.clear();
    await FirebaseFirestore.instance
        .collection('bankCustomer')
        .where('idCustomer', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final allData =
            value.docs.map((e) => BankCustomer.fromJson(e.data())).toList();
        listBankCustomer.value = allData;
        listBankCustomer.refresh();
      }
    });
  }
}
