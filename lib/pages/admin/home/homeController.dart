import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/AuthService.dart';
import 'package:tiendien_alias/Sevice/RealTimeDatabaseService.dart';
import 'package:tiendien_alias/dialog/dialog.dart';
import 'package:tiendien_alias/models/dichVu.dart';
import 'package:tiendien_alias/models/dichVuMain.dart';
import 'package:tiendien_alias/models/donHang.dart';
import 'package:tiendien_alias/models/historyPayment.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/provider/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  UserProvider userProvider = UserProvider();
  Rxn<UserModel> currentUser = Rxn();
  RxList<DichVu> listDichVu = RxList();
  RxList<DichVuMain> listDichVuMain = RxList();
  RxList<DonHangModel> listDonHang = RxList();
  final usersQuery = FirebaseDatabase.instance.ref().child('dichVu');
  RxNum length = RxNum(0);
  @override
  void onInit() async {
    super.onInit();
    await getCurrentUser();
    await onChangeValue();
  }

  getCurrentUser() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      if (value.exists) {
        currentUser.value = UserModel.fromJson(value.data()!);
      }
    });
  }

  onChangeValue() async {
    FirebaseFirestore.instance
        .collection('historyPayment')
        .snapshots()
        .listen((event) async {
      await getListHistoryPayment();
    });
  }

  getListHistoryPayment() async {
    length.value = 0;
    await FirebaseFirestore.instance
        .collection('historyPayment')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final allData =
            value.docs.map((e) => HistoryPayment.fromJson(e.data())).toList();
        allData.sort(
          (a, b) => b.createdDate.compareTo(a.createdDate),
        );
        for (var item in allData) {
          num quantity = item.listElectricityBill
              .where((element) => element.isPayment == false)
              .length;
          length.value += quantity;
        }
        print(length.value);
      }
    });
  }

  AuthService authService = AuthService();
  HomeController();
  signOut() {
    authService.signOutUser();
    Get.offAllNamed("/login");
  }
}
