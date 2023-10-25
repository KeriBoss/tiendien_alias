import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';

class BankInfoAdminController extends GetxController {
  final nameCustomerController = TextEditingController();
  final stkCustomerController = TextEditingController();
  final nameBankController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Rxn<BankCustomer> customerBank = Rxn<BankCustomer>();

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
    await FirebaseFirestore.instance
        .collection('adminBank')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        customerBank.value = BankCustomer.fromJson(value.docs.first.data());
      }
    });
  }

  Future updateBank() async {
    final docBankAdmin =
        FirebaseFirestore.instance.collection('adminBank').doc("admin");
    BankCustomer bankCustomer = BankCustomer(
        id: 'admin',
        idCustomer: FirebaseAuth.instance.currentUser!.uid,
        nameCustomer: nameCustomerController.text.trim(),
        stkBank: stkCustomerController.text.trim(),
        nameBank: nameBankController.text.trim(),
        logoBank: "");
    docBankAdmin.set(bankCustomer.toJson()).whenComplete(() {
      Get.snackbar(
        'Thông báo',
        'Thêm thành công',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }
}
