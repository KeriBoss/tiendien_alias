import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import '../../../Sevice/RealTimeDatabaseService.dart';
import '../../../models/customerBank.dart';

class BankInfoController extends GetxController {
  final nameCustomerController = TextEditingController();
  final stkCustomerController = TextEditingController();
  final nameBankController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Rxn<CustomerBankModel> customerBank = Rxn<CustomerBankModel>();

  @override
  void onInit() async {
    // TODO: implement onInit
    await getInformationBank();
    if (customerBank.value != null) {
      loadData();
    }
    super.onInit();
  }

  loadData() {
    nameCustomerController.text = customerBank.value!.nameCustomer;
    stkCustomerController.text = customerBank.value!.stkBank;
    nameBankController.text = customerBank.value!.nameBank;
  }

  getInformationBank() async {
    await FirebaseFirestore.instance.collection('customerBank')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((value) {
        if(value.exists) {
          customerBank.value = CustomerBankModel.fromJson(value.data()!);
        }
    });

  }

  Future updateBank() async {
    final docCustomerBank = FirebaseFirestore.instance.
    collection('customerBank').
    doc(FirebaseAuth.instance.currentUser!.uid);

    CustomerBankModel bankModel = CustomerBankModel(
        FirebaseAuth.instance.currentUser!.uid,
        nameCustomerController.text.trim(),
        stkCustomerController.text.trim(),
        nameBankController.text.trim()
    );
    final data = bankModel.toJson();
    await docCustomerBank.set(data);
    Get.snackbar("Thông báo", "Lưu thành công", backgroundColor: Colors.white);
  }


}
