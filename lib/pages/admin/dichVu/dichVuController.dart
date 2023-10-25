import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
class DichVuController extends GetxController {
  var fireStoreRef = FirebaseFirestore.instance.collection('service');
  var priceReportController = TextEditingController();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadData();
  }

  Future<void> loadData() async {

  }

  updatePriceReport() async {
    //fireStoreRef.doc("serviceReport").set();
  }
}