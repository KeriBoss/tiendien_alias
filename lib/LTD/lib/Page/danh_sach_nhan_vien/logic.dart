import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/Users.dart';

class DanhSachNhanVienLogic extends GetxController {
  RxList<UserModelLTD> listUserGa = RxList();
  RxList<UserModelLTD> listUserMen = RxList();
  RxList<UserModelLTD> listUserFull = RxList();
  RxString searchGa = RxString('');
  RxString searchMen = RxString('');
  RxString searchFull = RxString('');
  List<UserModelLTD> listUserGaTemp = [];
  List<UserModelLTD> listUserMenTemp = [];
  List<UserModelLTD> listUserFullTemp = [];

  loadUserGa() async {
    listUserGa.clear();
    await FirebaseFirestore.instance
        .collection('usersltd')
        .where("role", isEqualTo: 2)
        .get()
        .then((value) {
      final listData = value.docs
          .map<UserModelLTD>((item) => UserModelLTD.fromJson(item.data()));
      listUserGaTemp.addAll(listData);
    });
    listUserGa.value = listUserGaTemp;
    listUserGa.refresh();
  }

  loadUserMen() async {
    listUserMen.clear();
    await FirebaseFirestore.instance
        .collection('usersltd')
        .where("role", isEqualTo: 3)
        .get()
        .then((value) {
      final listData = value.docs
          .map<UserModelLTD>((item) => UserModelLTD.fromJson(item.data()));
      listUserMenTemp.addAll(listData);
    });
    listUserMen.value = listUserMenTemp;
    listUserMen.refresh();
  }

  loadUserFull() async {
    listUserFull.clear();
    await FirebaseFirestore.instance
        .collection('usersltd')
        .where("role", isEqualTo: 4)
        .get()
        .then((value) {
      final listData = value.docs
          .map<UserModelLTD>((item) => UserModelLTD.fromJson(item.data()));
      listUserFullTemp.addAll(listData);
    });
    listUserFull.value = listUserFullTemp;
    listUserFull.refresh();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadUserGa();
    await loadUserMen();
    await loadUserFull();
  }

  void searchStringGa() {
    if (searchGa.value.isNotEmpty) {
      listUserGa.value = listUserGaTemp.where((p0) {
        if (p0.phone.toLowerCase().contains(searchGa.value.toLowerCase()) ||
            p0.username.toLowerCase().contains(searchGa.value.toLowerCase())) {
          return true;
        }
        return false;
      }).toList();
    } else {
      listUserGa.value = listUserGaTemp;
    }
  }

  void searchStringMen() {
    if (searchMen.value.isNotEmpty) {
      listUserMen.value = listUserMenTemp.where((p0) {
        if (p0.phone.toLowerCase().contains(searchMen.value.toLowerCase()) ||
            p0.username.toLowerCase().contains(searchMen.value.toLowerCase())) {
          return true;
        }
        return false;
      }).toList();
    } else {
      listUserMen.value = listUserMenTemp;
    }
  }

  void searchStringFull() {
    if (searchFull.value.isNotEmpty) {
      listUserFull.value = listUserFullTemp.where((p0) {
        if (p0.phone.toLowerCase().contains(searchFull.value.toLowerCase()) ||
            p0.username
                .toLowerCase()
                .contains(searchFull.value.toLowerCase())) {
          return true;
        }
        return false;
      }).toList();
    } else {
      listUserFull.value = listUserFullTemp;
    }
  }

  onChange() async {
    await FirebaseFirestore.instance
        .collection("usersltd")
        .snapshots()
        .listen((event) {
      loadUserGa();
      loadUserMen();
      loadUserFull();
    });
  }
}
