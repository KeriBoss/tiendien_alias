import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/DiaLog.dart';
import 'package:tiendien_alias/LTD/lib/Models/DinhMuc.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/LoHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/Users.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class ThemDonHangLogic extends GetxController {
  RxList<DinhMuc> listDinhMuc = RxList<DinhMuc>();
  DinhMuc? selected;

  final storageRef = FirebaseStorage.instance.ref();
  Rxn<UserModelLTD> currentUser = Rxn();
  final soXap = TextEditingController();
  final tenLoHang = TextEditingController();
  final maDH = TextEditingController();
  RxString maHang = RxString('');
  RxList<double> listXap = RxList<double>();
  RxDouble sum = RxDouble(0.0);
  Rxn<File> file = Rxn<File>();
  double tong = 0.0;
  var key = GlobalKey<FormState>();

  RxList<DonHang> listDonHang = RxList();

  PlatformFile? platformFile;

  Future selectedImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    final path = result.files.single.path!;
    platformFile = result.files.first;
    file.value = File(path);
  }

  void addXap(double m) {
    listXap.value.add(m);
    soXap.clear();
    listXap.refresh();
  }

  loadDinhMuc() async {
    List<DinhMuc> listTemp = [];
    listDinhMuc.clear();
    await FirebaseFirestore.instance.collection('DinhMuc').get().then((value) {
      final listData =
          value.docs.map<DinhMuc>((item) => DinhMuc.fromJson(item.data()));
      listTemp.addAll(listData);
    });
    listDinhMuc.value = listTemp;
    listDinhMuc.refresh();
  }

  void Sum() {}

  Future<void> addList() async {
    DiaLog.showIndicatorDialog();
    RxDouble sum1 = RxDouble(0.0);
    List<double> listTempXap = List.from(listXap);
    var uuid = Uuid();
    String id = uuid.v4(options: {'rng': UuidUtil.cryptoRNG});
    String linkImg = "";
    String nameImg = "";
    if (platformFile != null) {
      final path = 'DonHang/$id/${platformFile!.name}';
      final ref = storageRef.child(path);
      await ref.putFile(file.value!);
      linkImg = (await ref.getDownloadURL()).toString();
      nameImg = platformFile!.name;
    }

    for (var item in listXap.value) {
      sum.value += double.parse(item.toString());
    }
    listDinhMuc.sort((a, b) => b.soM.compareTo(a.soM));
    for (var item in listDinhMuc) {
      if (sum.value - item.soM > 0) {
        selected = item;
        break;
      }
    }
    double soDu = sum.value - selected!.soM;

    DonHang donHang = DonHang(
        id,
        "",
        sum.value,
        linkImg,
        nameImg,
        maDH.text,
        listTempXap,
        soDu,
        TrangThai.chuaco,
        TrangThai.chuaco,
        DateTime.now(),
        DateTime.now(),
        "",
        "",
        DateTime.now(),
        selected!);
    for (var item in donHang.listSap) {
      sum1.value += double.parse(item.toString());
    }
    donHang.listSap = listTempXap;
    listDonHang.value.add(donHang);
    Get.close(1);
    listDonHang.refresh();
    listXap.clear();

    maDH.clear();
    sum.value = 0;
  }

  deleteDH(DonHang donHang) {
    listDonHang.value.remove(donHang);
    listDonHang.refresh();
  }

  deleteXap() {
    listXap.removeLast();
  }

  addDonHang() async {
    DiaLog.showIndicatorDialog();
    final docPost = FirebaseFirestore.instance.collection('LoHang').doc();
    String id = docPost.id;
    LoHang loHang = LoHang(id, tenLoHang.text.trim(), DateTime.now());

    final data = loHang.toJson();
    await docPost.set(data);
    for (var donHang in listDonHang) {
      donHang.idLo = id;
      await FirebaseFirestore.instance
          .collection('donHang')
          .doc(donHang.id)
          .set(donHang.toJson());
    }

    Get.snackbar("Thông báo", "Thêm lô hàng thành công ",
        backgroundColor: Colors.green);
    Get.close(1);
    listDonHang.clear();
  }

  // addDonHang() async {
  //   DiaLog.showIndicatorDialog();
  //   final docPost = FirebaseFirestore.instance.collection('DonHang').doc();
  //   String id = docPost.id;
  //
  //   String linkImg = "";
  //   String nameImg = "";
  //   if (platformFile != null) {
  //     final path = 'DonHang/$id/${platformFile!.name}';
  //     final ref = storageRef.child(path);
  //     await ref.putFile(file.value!);
  //     linkImg = (await ref.getDownloadURL()).toString();
  //     nameImg = platformFile!.name;
  //   }
  //     DonHang donHang = DonHang(
  //         id,
  //         sum.value,
  //         linkImg,
  //         nameImg,
  //         maHang.value.trim(),
  //         listXap.value,
  //         0.0,
  //         TrangThai.chuaco,
  //         TrangThai.chuaco,
  //         DateTime.now(),
  //         DateTime.now(),
  //         "","",DateTime.now()
  //     );
  //   final data = donHang.toJson();
  //     await docPost.set(data).whenComplete(() {
  //       Get.snackbar("Thông báo", "Thêm đơn hàng thành công ", backgroundColor: Colors.green);
  //       print("thêm thành công");
  //       listXap.clear();
  //       sum.value = 0.0;
  //       Get.close(1);
  //       Get.toNamed('/danhsachdonhang');
  //
  //     });
  // }
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadDinhMuc();
  }
}
