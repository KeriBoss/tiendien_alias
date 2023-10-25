import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/notification.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryWithDrawController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  UserModelProvider userProvider = UserModelProvider();
  RxList<GiaoDichModel> listNapTien = RxList<GiaoDichModel>();
  RxList<GiaoDichModel> listRutTien = RxList<GiaoDichModel>();
  List<GiaoDichModel> listSourceNapTien = [];
  List<GiaoDichModel> listSourceRutTien = [];
  final napTienQuery = FirebaseFirestore.instance.collection('napTien');

  final userQuery = FirebaseFirestore.instance.collection('users');

  RxInt price = RxInt(0);
  final formKey = GlobalKey<FormState>();
  TextEditingController txtXu = TextEditingController();
  List<String> listType = ["All", "Hoàn thành", "Chờ xử lý", "Đã hủy"];
  List<String> listType2 = ["All", "Đã hoàn thành", "Chờ xử lý", "Đã hủy"];

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    await onChangeValue();
  }

  dataNapTien() async {
    listNapTien.clear();
    List<GiaoDichModel> list = [];
    await FirebaseFirestore.instance
        .collection('napTien')
        .where('loaiGiaoDich', isEqualTo: "napTien")
        .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final allData = value.docs
          .map<GiaoDichModel>((value) => GiaoDichModel.fromJson(value.data()))
          .toList();
      list = allData;
    });
    list.sort((a, b) => b.time.compareTo(a.time));
    listNapTien.value = list;
    listSourceNapTien = list;
    listNapTien.refresh();
  }

  dataRutTien() async {
    listRutTien.clear();
    List<GiaoDichModel> list = [];
    await FirebaseFirestore.instance
        .collection('napTien')
        .where('loaiGiaoDich', isEqualTo: "rutTien")
        .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final allData = value.docs
          .map<GiaoDichModel>((value) => GiaoDichModel.fromJson(value.data()))
          .toList();
      list = allData;
    });
    list.sort((a, b) => b.time.compareTo(a.time));
    listRutTien.value = list;
    listSourceRutTien = list;
    listRutTien.refresh();
  }

  onChangeValue() async {
    FirebaseFirestore.instance
        .collection('napTien')
        .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) async {
      await dataNapTien();
      await dataRutTien();
    });
  }
}
