import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:tiendien_alias/models/customerBank.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../../../dialog/dialog.dart';
import '../../../provider/userModelProvider.dart';

class XuLyRutTienController extends GetxController {
  GiaoDichModel giaoDich = Get.arguments;
  Rxn<File> file = Rxn<File>();
  UserModelProvider userProvider = UserModelProvider();
  Rxn<BankCustomer> bankCustomer = Rxn<BankCustomer>();
  DatabaseProvider databaseProvider = DatabaseProvider();

  Future<void> selectImages() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    final path = result.files.single.path!;
    file.value = File(path);
  }

  chuyenKhoan() async {
    if (file.value != null) {
      String linkImage = "";
      DiaLog.showIndicatorDialog();
      final path = "ChuyenKhoan/${giaoDich.id}/${basename(file.value!.path)}";
      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file.value!);
      linkImage = (await ref.getDownloadURL()).toString();

      giaoDich.trangThai = 'Đã gửi - Chờ xác nhận';
      giaoDich.image = linkImage;

      await FirebaseFirestore.instance
          .collection('notification')
          .doc(giaoDich.code)
          .update({'status': 'Thành Công'});

      await databaseProvider.editModel(
        collection: 'napTien',
        id: giaoDich.id,
        toJsonModel: giaoDich.toJson(),
        title: "Thông báo",
        message: "Đã xác nhận",
        numGetClose: 2,
      );
    } else {
      Get.snackbar("Thông báo", "Vui lòng chọn ảnh đã chuyển khoản",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  reject() async {
    DiaLog.showIndicatorDialog();
    var user = await userProvider.getUserById(giaoDich.idUser);
    user.money = user.money + num.parse(giaoDich.soTien);
    await databaseProvider.editModel(
        collection: 'users', id: user.id, toJsonModel: user.toJson());

    await FirebaseFirestore.instance
        .collection('notification')
        .doc(giaoDich.code)
        .update({'status': 'Đã huỷ'});

    await FirebaseFirestore.instance
        .collection('napTien')
        .doc(giaoDich.id)
        .update({
      'trangThai': 'Đã huỷ',
    }).then((value) {
      Get.close(3);
      Get.snackbar("Thông báo", "Đã huỷ thành công",
          backgroundColor: Colors.green, colorText: Colors.white);
    });
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getBankCustomer();
  }

  getBankCustomer() async {
    print(giaoDich.idBank);
    await FirebaseFirestore.instance
        .collection('bankCustomer')
        .doc(giaoDich.idBank)
        .get()
        .then((value) {
      if (value.exists) {
        bankCustomer.value = BankCustomer.fromJson(value.data()!);
      }
    });
  }
}
