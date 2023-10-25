import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Firebase/SMS.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/TraHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/Users.dart';
import 'package:tiendien_alias/LTD/lib/Provider.dart';

class HomeGiaCongLogic extends GetxController {
  RxInt currentIndex = 0.obs;
  MessegingService messegingService = MessegingService();
  UserProvider userProvider = UserProvider();
  Rxn<UserModelLTD> currentUser = Rxn();

  RxList<DonHang> listDonHang = RxList();
  RxList<DonHang> listDH = RxList();
  RxList<TraHang> listTraHang = RxList();

  List<String> listIdTemp = [];

  loadListDonHang() async {
    List<DonHang> listTemp = [];
    listDonHang.clear();
    await FirebaseFirestore.instance
        .collection('donHang')
        .where("idGiaCongGa", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final listData = value.docs
          .map<DonHang>((item) => DonHang.fromJson(item.data()))
          .toList();
      for (var item in listData) {
        listIdTemp.add(item.id);
      }
      listTemp = listData;
    });
    await FirebaseFirestore.instance
        .collection('donHang')
        .where("idGiaCongMen",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final listData = value.docs
          .map<DonHang>((item) => DonHang.fromJson(item.data()))
          .toList();
      for (var item in listData) {
        if (listIdTemp.contains(item.id) == false) {
          listTemp.add(item);
        }
      }
    });
    listDonHang.value = listTemp;
    print(listDonHang.length);
    listDonHang.refresh();
  }

  //
  List<String> listImage = [
    "http://www.collectrenaissance.com/"
        "images/products/lrg/renaissance-birds-eye-stripe-"
        "bedding-set-RHR-101-BE-BE_lrg.jpg",
    "https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?"
        "ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGJlZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"
  ];

  loadListTraHang() async {
    List<TraHang> listTraHangTemp = [];
    listTraHang.clear();
    await FirebaseFirestore.instance.collection('traHang').get().then((value) {
      final listData = value.docs
          .map<TraHang>((item) => TraHang.fromJson(item.data()))
          .toList();
      listTraHangTemp.addAll(listData);
    });
    listTraHang.value = listTraHangTemp;
    listTraHang.refresh();
  }

  RxNum getSoLuongGaTra(String idDonHang) {
    RxNum soLuongGaTra = RxNum(0);
    for (var element in listTraHang) {
      if (element.idDonHang == idDonHang) {
        soLuongGaTra.value += element.soGaXacNhan;
      }
    }
    soLuongGaTra.refresh();
    return soLuongGaTra;
  }

  RxNum getSoLuongMenTra(String idDonHang) {
    RxNum soLuongMenTra = RxNum(0);
    listTraHang.forEach((element) {
      if (element.idDonHang == idDonHang) {
        print(element.soMenXacNhan);
        soLuongMenTra.value += element.soMenXacNhan;
      }
    });
    return soLuongMenTra;
  }

  onChange() async {
    await FirebaseFirestore.instance
        .collection("traHang")
        .snapshots()
        .listen((event) async {
      await loadListTraHang();
    });
  }

  onchangeDonHang() async {
    await FirebaseFirestore.instance
        .collection("donHang")
        .snapshots()
        .listen((event) async {
      await loadListDonHang();
    });
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    messegingService.requestPermission();
    messegingService.loadFCM();
    messegingService.listenFCM();
    if (FirebaseAuth.instance.currentUser != null) {
      currentUser.value = await userProvider.getUser();
    }
    await onChange();
    await onchangeDonHang();
  }
}
