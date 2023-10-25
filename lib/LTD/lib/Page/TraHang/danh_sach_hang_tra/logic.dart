import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/TraHang.dart';

class DanhSachHangTraLogic extends GetxController {
  Rxn<DonHang> donHang = Rxn();
  RxList<TraHang> listTraHang = RxList();
  RxList<TraHang> listGa = RxList();
  RxList<TraHang> listMen = RxList();

  loadListTraHang() async {
    List<TraHang> listTraHangTemp = [];
    listTraHang.clear();
    await FirebaseFirestore.instance
        .collection('traHang').where("idDonHang", isEqualTo: donHang.value!.id)
        .get()
        .then((value) {
      final listData =
      value.docs.map<TraHang>((item) => TraHang.fromJson(item.data()));
      listTraHangTemp.addAll(listData);
    });
    listTraHang.value = listTraHangTemp;
    listGa.value = listTraHang.where((p0) => p0.soGaTra != 0).toList();
    listMen.value = listTraHang.where((p0) =>  p0.soMenTra != 0).toList();

    listTraHang.refresh();
  }
  onChange() async {
    await FirebaseFirestore.instance.collection("traHang").snapshots().listen((event) async {
      await loadListTraHang();
    });
  }
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments != null){
      donHang.value = Get.arguments;
    }
    //await loadListTraHang();
    await onChange();
    print(listGa.value.length);
    print(listMen.value.length);
  }

}
