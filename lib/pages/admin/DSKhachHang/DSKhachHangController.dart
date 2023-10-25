import 'dart:convert';

import 'package:tiendien_alias/Sevice/RealTimeDatabaseService.dart';
import 'package:tiendien_alias/dialog/dialog.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/nhanvien.dart';
import 'package:tiendien_alias/models/user.dart';

import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:tiendien_alias/provider/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../home/homeController.dart';

class DSKhachHangController extends GetxController {
  MainController _mainController = Get.find();
  HomeController homeController = Get.find();
  UserProvider userProvider = UserProvider();
  RxList<UserModel> listNhanVien = RxList();
  List<UserModel> listSource = [];

  final userQuery = FirebaseDatabase.instance.ref().child('user');
  TextEditingController textEditingController = TextEditingController();
  RxInt price = RxInt(0);
  DSKhachHangController();

  TextEditingController txtXu = TextEditingController();
  final storage = FirebaseStorage.instance.ref();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadDataNhanVien();
    userQuery.orderByChild("role").equalTo(2).onValue.listen((event) {
      loadDataNhanVien();
    });
  }

  Future loadDataNhanVien() async {
    List<UserModel> list = [];
    final snapshot = await userQuery.orderByChild("role").equalTo(2).get();
    for (var item in snapshot.children) {
      Map<String, dynamic> jsonvalue = json.decode(json.encode(item.value));
      list.add(UserModel.fromJson(jsonvalue));
    }
    listNhanVien.value = list;
    listSource = list;
  }

  timKiem(String text) {
    if (text.isNotEmpty) {
      listNhanVien.value = listSource
          .where((element) => element.name.toLowerCase().contains(text))
          .toList();
    } else {
      listNhanVien.value = listSource;
    }
  }
}
