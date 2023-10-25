import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/RealTimeDatabaseService.dart';
import 'package:tiendien_alias/dialog/dialog.dart';
import 'package:tiendien_alias/models/customerBank.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:tiendien_alias/provider/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:intl/intl.dart';

class NapTienController extends GetxController {
  RxInt price = RxInt(0);
  NapTienController();
  late Rxn<CustomerBankModel> customerBankModel = Rxn();
  final oCcy = NumberFormat("#,##0", "en_US");
  final formKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  final storage = FirebaseStorage.instance.ref();

  @override
  void onInit() {
    getInformationBank();
    super.onInit();
  }

  void updatePrice() {
    int xu = int.parse(priceController.text);
    int total = xu;
    price.value = total;
  }

  getInformationBank() async {
    await FirebaseFirestore.instance
        .collection('adminBank')
        .get()
        .then((value) {
      customerBankModel.value = CustomerBankModel(
          value.docs.first['id'],
          value.docs.first['nameCustomer'],
          value.docs.first['stkBank'],
          value.docs.first['nameBank']);
    });
  }

  thucHienNapTien() async {
    DiaLog.showIndicatorDialog();
    var currentUser = await UserModelProvider().getCurrentUser();
    final docNapTien = FirebaseFirestore.instance.collection('napTien').doc();

    DateTime now = DateTime.now();
    Random random = Random();
    int randomNumber = random.nextInt(10000) + 10000;

    GiaoDichModel napTienModel = GiaoDichModel(
        docNapTien.id,
        randomNumber.toString(),
        currentUser!.id,
        currentUser!.name,
        '',
        now,
        "",
        (price.value).toString(),
        LoaiGiaoDich.napTien,
        "Chờ xử lý",
        "");
    await docNapTien.set(napTienModel.toJson()).then((value) => Get.close(1));
    if (DateTime.now().day >= 12) {
      showCofirmDialog(
          "Đã gửi yêu cầu nạp  ${priceController.text} VNĐ",
          "Vui lòng chuyển khoản ${oCcy.format(price.value)} đ đến\n"
              "Số tài khoản ${customerBankModel.value!.stkBank} \n"
              "Ngân hàng ${customerBankModel.value!.nameBank} \n"
              "Tên tài khoản ${customerBankModel.value!.nameCustomer} \n"
              "Với cú pháp ${currentUser.name} ${priceController.text}");
    } else {
      showCofirmDialog("Thông báo", "Nạp tiền thành công");
    }

    int xu = int.parse(priceController.text);
    int total = xu;
    price.value = total;
  }
}
