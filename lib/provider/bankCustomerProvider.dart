import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BankCustomerProvider {
  Future<BankCustomer?> getBankCustomer(String idUser) async {
    BankCustomer? bankCustomer;
    await FirebaseFirestore.instance
        .collection('bankCustomer')
        .where('idCustomer', isEqualTo: idUser)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        bankCustomer = BankCustomer.fromJson(value.docs.first.data());
      }
    });

    return bankCustomer;
  }
}
