import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';

class ChiTietDonHangGiaCongLogic extends GetxController {
  Rxn<DonHang> donhang = Rxn();
  List list = [];
  var soLuong = TextEditingController();
  final key = GlobalKey<FormState>();
  PlatformFile? platformFile;
  Rxn<File> file = Rxn<File>();

  RxInt gaTra = RxInt(0);
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments != null){
      list = Get.arguments;
      donhang.value = list.first;
    }
    await getDataTraHang();
  }

  Future selectedImage() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.image
    );
    if(result == null) return;
    final path = result.files.single.path!;
    platformFile = result.files.first;
    file.value = File(path);
  }
  nhanDonHang() async {
    if(donhang.value!.idGa == FirebaseAuth.instance.currentUser!.uid){
      donhang.value!.trangThaiGa = TrangThai.daxacnhan;
    }
    if(donhang.value!.idMen == FirebaseAuth.instance.currentUser!.uid){
      donhang.value!.trangThaiMen = TrangThai.daxacnhan;
    }
    await FirebaseFirestore.instance.collection("donHang")
        .doc(donhang.value!.id).update(donhang.value!.toJson())
        .whenComplete(() async {
      Get.close(1);
      Get.snackbar("Thông báo", "Nhận đơn hàng thành công", backgroundColor: Colors.green);
    });

  }
  getDataTraHang() async {
    await FirebaseFirestore.instance.collection("donHang")
        .doc(donhang.value!.id).collection("TraHang")
        .where("idUser", isEqualTo: donhang.value!.idGa).get().then((value) {
      final allData = value.docs.map((e) => e.data()).toList();
      for(var item in allData){
        gaTra += item['SoLuong'];
      }
    });
  }
  traHang() async {
    String linkImg = "";
    if (file.value != null) {
      final path = 'traHang/${donhang.value!.id}/${basename(file.value!.path)}';
      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file.value!);
      linkImg = (await ref.getDownloadURL()).toString();
    }
    FirebaseFirestore.instance.collection("donHang").doc(donhang.value!.id).collection("TraHang").doc().set({
      'SoLuong' : int.parse(soLuong.text),
      'NgayTra' : DateTime.now(),
      'id' : FirebaseFirestore.instance.collection("DonHang")
          .doc(donhang.value!.id).collection("TraHang").doc().id,
      'idUser' : FirebaseAuth.instance.currentUser!.uid,
      'image' : linkImg,
    });
  }


}
