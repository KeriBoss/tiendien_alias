import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AddBillQRController extends GetxController {

  final formKey = GlobalKey<FormState>();
  final codeBillController = TextEditingController();
  final priceBillController = TextEditingController();
  final discountBillController = TextEditingController();
  RxDouble priceDiscount = RxDouble(0.0);


  calculatorDiscount() {
    if(priceBillController.text != "" && discountBillController.text != "") {
      double price = double.parse(priceBillController.text.trim());
      double discount = double.parse(discountBillController.text.trim());

      priceDiscount.value = (price * discount) / 100;
    } else {
      priceDiscount.value = 0.0;
    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    codeBillController.dispose();
    priceBillController.dispose();
    discountBillController.dispose();
    super.dispose();
  }

}