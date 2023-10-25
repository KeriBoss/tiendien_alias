import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../../../provider/userModelProvider.dart';
import '../home/homeController.dart';

class ThanhKhoanController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  final MainController _mainController = Get.put(MainController());
  HomeController homeController = Get.put(HomeController());
  UserModelProvider userProvider = UserModelProvider();
  RxList<GiaoDichModel> listNapTien = RxList<GiaoDichModel>();
  RxList<GiaoDichModel> listRutTien = RxList<GiaoDichModel>();
  List<GiaoDichModel> listSourceNapTien = [];
  List<GiaoDichModel> listSourceRutTien = [];
  final napTienQuery = FirebaseFirestore.instance.collection('napTien');

  final userQuery = FirebaseFirestore.instance.collection('users');

  RxInt price = RxInt(0);
  ThanhKhoanController();
  final oCcy = NumberFormat("#,##0", "en_US");
  final formKey = GlobalKey<FormState>();
  TextEditingController txtXu = TextEditingController();
  final storage = FirebaseStorage.instance.ref();
  List<String> listType = ["All", "Hoàn thành", "Chờ xử lý", "Đã hủy"];
  List<String> listType2 = ["All", "Đã hoàn thành", "Chờ xử lý", "Đã hủy"];

  DatabaseProvider databaseProvider = DatabaseProvider();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    await onChangeValue();
  }

  void xacThuc(GiaoDichModel napTienModel) async {
    _mainController.showIndicadorDialog();
    UserModel user = await userProvider.getUserById(napTienModel.idUser);

    napTienModel.trangThai = "Hoàn thành";
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('HH:mm:ss dd-MM-yyyy').format(now);
    napTienModel.timeSuccess = formattedDate;

    await FirebaseFirestore.instance
        .collection('notification')
        .doc(napTienModel.code)
        .update({'status': 'Thành công'});

    await napTienQuery.doc(napTienModel.id).set(napTienModel.toJson());
    user.money = (user.money + num.parse(napTienModel.soTien));
    await databaseProvider.editModel(
        collection: 'users',
        id: user.id,
        toJsonModel: user.toJson(),
        title: 'Thông báo',
        message: 'Đã chuyển xu',
        numGetClose: 2);
  }

  void huy(GiaoDichModel napTienModel) async {
    DiaLog.showIndicatorDialog();
    napTienModel.trangThai = "Đã hủy";

    await FirebaseFirestore.instance
        .collection('notification')
        .doc(napTienModel.code)
        .update({'status': 'Đã huỷ'});

    await databaseProvider.editModel(
        collection: 'napTien',
        id: napTienModel.id,
        toJsonModel: napTienModel.toJson(),
        title: 'Thông báo',
        message: 'Đã hủy chuyển xu',
        numGetClose: 2);
  }

  reject(GiaoDichModel rutTienModel) async {
    DiaLog.showIndicatorDialog();
    var user = await userProvider.getCurrentUser();
    user!.money = user.money + num.parse(rutTienModel.soTien);
    await databaseProvider.editModel(
        collection: 'users', id: user.id, toJsonModel: user.toJson());

    await FirebaseFirestore.instance
        .collection('napTien')
        .doc(rutTienModel.id)
        .update({
      'trangThai': 'Đã huỷ',
    }).then((value) {
      Get.close(2);
      Get.snackbar("Thông báo", "Đã huỷ thành công",
          backgroundColor: Colors.green, colorText: Colors.white);
    });
  }

  dataNapTien() async {
    listNapTien.clear();
    List<GiaoDichModel> list = [];
    await FirebaseFirestore.instance
        .collection('napTien')
        .where('loaiGiaoDich', isEqualTo: "napTien")
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
        .snapshots()
        .listen((event) async {
      await dataNapTien();
      await dataRutTien();
    });
  }
}
