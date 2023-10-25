import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/DiaLog.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/TraHang.dart';
import 'package:path/path.dart';

class ThongKeTraHangLogic extends GetxController {
  Rxn<DonHang> donhang = Rxn();
  RxList<TraHang> listTraHang = RxList();
  var soGaTra = TextEditingController();
  var soMenTra = TextEditingController();
  final key = GlobalKey<FormState>();
  PlatformFile? platformFile;
  Rxn<File> file = Rxn<File>();
  RxInt gaTra = RxInt(0);

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments != null) {
      donhang = Get.arguments;
      // await FirebaseFirestore.instance.collection("donHang")
      //     .doc(donhang.value!.id).collection("TraHang").snapshots().listen((event) {
      //   getDataTraHang();
      // });
    }

    await  getDataTraHang();

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

  getDataTraHang() async {
    listTraHang.value.clear();
    List<TraHang> listTemp = [];
    await FirebaseFirestore.instance.collection("traHang")
        .where("idDonHang", isEqualTo: donhang.value!.id)
        .where("idGiaCongGa", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      final allData =
      value.docs.map<TraHang>((item) => TraHang.fromJson(item.data()));
      listTemp.addAll(allData);
    });
    for(var item in listTemp){
      if(item.trangThaiGa == TrangThaiTra.choXacNhan){
        gaTra.value += item.soGaTra.toInt();
      }
    }
    listTraHang.value = listTemp;
    listTraHang.refresh();
    print(gaTra.value);
  }
  traHang() async {
    DiaLog.showIndicatorDialog();
    String linkImg = "";
    if (file.value != null) {
      final path = 'traHang/${donhang.value!.id}/${basename(file.value!.path)}';
      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file.value!);
      linkImg = (await ref.getDownloadURL()).toString();
    }
    final docTraHang = FirebaseFirestore.instance.collection("traHang").doc();
    String id = docTraHang.id;
    TraHang traHang = TraHang(
        id: id,
        idGiaCongGa: FirebaseAuth.instance.currentUser!.uid,
        idGiaCongMen: "",
        idLoHang: donhang.value!.idLo,
        idDonHang: donhang.value!.id,
        nameImg: "",
        urlImg: linkImg,
        ngayGiao: DateTime.now(),
        ngayXacNhanGa: DateTime.now(),
        ngayXacNhanMen: DateTime.now(),
        soGaTra: num.parse(soGaTra.text),
        soMenTra: 0,
        soGaXacNhan: 0,
        soMenXacNhan: 0,
        trangThaiGa: TrangThaiTra.choXacNhan,
        trangThaiMen: TrangThaiTra.choXacNhan,
        ghiChuGa: "",
        ghiChuMen: ""
    );

    final data = traHang.toJson();
    await docTraHang.set(data).whenComplete((){
      Get.close(2);
      Get.snackbar("Thông báo", "Trả thành công chờ xác nhận!!!", backgroundColor: Colors.green);
    });
  }

}
