import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../Sevice/RealTimeDatabaseService.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'dart:convert';

import '../../../models/customerBank.dart';
import '../../../models/giaoDich.dart';

class TransactionHistoryController extends GetxController {
  Rxn<UserModel> user = Rxn<UserModel>();
  RxList<GiaoDichModel> listGiaoDich = RxList<GiaoDichModel>();
  List<GiaoDichModel> listSource = [];
  final usersQuery = FirebaseDatabase.instance.ref().child('napTien');
  List<String> listType = ['All', 'Nạp tiền', 'Rút tiền'];
  String? selectedType;
  Rxn<CustomerBankModel> customerBank = Rxn<CustomerBankModel>();
  @override
  void onInit() async {
    // TODO: implement onInit
    await getUser();
    await loadLichSuGiaoDich();
    await onChangeValue();
    await getInformationBank();
    super.onInit();
  }

  Future<UserModel?> getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (FirebaseAuth.instance.currentUser != null) {
      final usersRef = FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (users, _) => users.toJson(),
          );
      if (auth.currentUser != null) {
        UserModel userModel = await usersRef
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) => value.data()!);
        print(userModel.toJson());
        return userModel;
      }
    }
    return null;
  }

  getUser() async {
    user.value = await getCurrentUser();
  }

  getInformationBank() async {
    await FirebaseFirestore.instance
        .collection('adminBank')
        .get()
        .then((value) {
      customerBank.value = CustomerBankModel(
          value.docs.first['id'],
          value.docs.first['nameCustomer'],
          value.docs.first['stkBank'],
          value.docs.first['nameBank']);
    });
  }

  loadLichSuGiaoDich() async {
    listGiaoDich.clear();
    List<GiaoDichModel> list = [];

    await FirebaseFirestore.instance.collection('napTien').get().then((value) {
      final allData = value.docs
          .map<GiaoDichModel>((value) => GiaoDichModel.fromJson(value.data()))
          .toList();
      for (var item in allData) {
        if (item.idUser == FirebaseAuth.instance.currentUser!.uid) {
          list.add(item);
        }
      }
    });
    list.sort((a, b) => b.time.compareTo(a.time));

    listSource = list;
    listGiaoDich.value = list;
    listGiaoDich.refresh();
  }

  onChangeValue() async {
    await FirebaseFirestore.instance
        .collection('napTien')
        .snapshots()
        .listen((event) {
      loadLichSuGiaoDich();
    });
  }

  xacNhanChuyenKhoan(String id) async {
    await FirebaseFirestore.instance
        .collection('napTien')
        .doc(id)
        .update({"trangThai": "Đã hoàn thành"}).then((value) => Get.back());
    loadLichSuGiaoDich();
  }
}
