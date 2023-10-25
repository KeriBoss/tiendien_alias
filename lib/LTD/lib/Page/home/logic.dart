import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Firebase/SMS.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/Users.dart';
import 'package:tiendien_alias/LTD/lib/Provider.dart';

class HomeLogic extends GetxController {
  Rxn<UserModelLTD> userModel = Rxn();
  RxInt currentIndex = 0.obs;
  MessegingService messegingService = MessegingService();
  UserProvider userProvider = UserProvider();
  Rxn<UserModelLTD> currentUser = Rxn();
  List<String> listImage = [
    "http://www.collectrenaissance.com/"
        "images/products/lrg/renaissance-birds-eye-stripe-"
        "bedding-set-RHR-101-BE-BE_lrg.jpg",
    "https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?"
        "ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGJlZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"
  ];

  RxList<DonHang> listDH = RxList();
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
    print(currentUser.toJson());
    await loadDataDonHang();
    print(listDH.length);
  }

  loadDataDonHang() async {
    listDH.clear();
    List<DonHang> list = [];
    await FirebaseFirestore.instance
        .collection('donHang')
        .orderBy("ngayTao", descending: true)
        .limit(6)
        .get()
        .then((value) {
      final listData =
          value.docs.map<DonHang>((item) => DonHang.fromJson(item.data()));
      list.addAll(listData);
    });

    listDH.value = list;
    listDH.refresh();
    // sum total bill
  }
}
