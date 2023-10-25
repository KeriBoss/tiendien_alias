import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';

class ThongTinTraHangLogic extends GetxController {
  DonHang donHang = Get.arguments;

  RxList<DonHang> list = RxList();
  List<DonHang> temp = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(donHang.idMen);
    loadListDonHang();
    print(list.length);

  }
  loadListDonHang() async {

    List<DonHang> listTemp = [];
    list.clear();
    await FirebaseFirestore.instance.collection("donHang").doc(donHang.id).collection("TraHang").
    where("idUser", isEqualTo: donHang.idMen)
        .get()
        .then((value) {
      final listData =
      value.docs.map<DonHang>((item) => DonHang.fromJson(item.data()));
      listTemp.addAll(listData);
    });
    list.value = listTemp;
    list.refresh();
  }
}