import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/TraHang.dart';

class XacNhanGaLogic extends GetxController {
  Rxn<TraHang> traHang = Rxn();
  Rxn<DonHang> donHang = Rxn();
  List<TraHang> listGa = [];
  num tong = 0;

  var soGa = TextEditingController();
  var notedController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments != null){
      traHang.value = Get.arguments[0];
      listGa = Get.arguments[1];
    }
    print(listGa.length);
    for(var item in listGa){
      tong += item.soGaXacNhan;
    }

    await FirebaseFirestore.instance.collection("donHang").doc(traHang.value!.idDonHang).get().then((value) {
      donHang.value = DonHang.fromJson(value.data()!);
    });
  }
  
  xacNhanGa() async {
    traHang.value!.soGaXacNhan = num.parse(soGa.text.trim());
    traHang.value!.ghiChuGa = notedController.text.trim();
    traHang.value!.trangThaiGa = TrangThaiTra.daXacNhan;
    traHang.value!.ngayXacNhanGa = DateTime.now();

    await FirebaseFirestore.instance.collection('traHang').doc(traHang.value!.id).update(traHang.value!.toJson());
    Get.close(1);
    Get.snackbar("Thông báo", "Xác nhận thành công",
      colorText: Colors.white,
      backgroundColor: Colors.green
    );
  }
}
