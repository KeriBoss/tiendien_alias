import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/TraHang.dart';

class XacNhanMenLogic extends GetxController {
  Rxn<TraHang> traHang = Rxn();
  var soMen = TextEditingController();
  var notedController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Rxn<DonHang> donHang = Rxn();
  List<TraHang> listMen = [];
  num tong = 0;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments != null){
      traHang.value = Get.arguments[0];
      listMen = Get.arguments[1];
    }
    for(var item in listMen){
      tong += item.soMenXacNhan;
    }

    await FirebaseFirestore.instance.collection("donHang").doc(traHang.value!.idDonHang).get().then((value) {
      donHang.value = DonHang.fromJson(value.data()!);
    });
  }

  xacNhanMen() async {
    traHang.value!.soMenXacNhan = num.parse(soMen.text.trim());
    traHang.value!.ghiChuMen = notedController.text.trim();
    traHang.value!.trangThaiMen = TrangThaiTra.daXacNhan;
    traHang.value!.ngayXacNhanMen = DateTime.now();

    await FirebaseFirestore.instance.collection('traHang').doc(traHang.value!.id).update(traHang.value!.toJson());
    Get.close(1);
    Get.snackbar("Thông báo", "Xác nhận thành công",
        colorText: Colors.white,
        backgroundColor: Colors.green
    );
  }
}
