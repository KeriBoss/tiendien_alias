import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PaymentMethodsController extends GetxController {
  RxList<BankCustomer> listBankCustomer = RxList();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getBankCustomer();
  }

  Future<void> getBankCustomer() async {
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
