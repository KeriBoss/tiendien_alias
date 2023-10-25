import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/LoHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/TraHang.dart';

class DanhSachDonHangLogic extends GetxController {
  LoHang? loHang;
  RxList<DonHang> listDonHang = RxList();
  RxList<TraHang> listTraHang = RxList();

  loadListDonHang() async {
    List<DonHang> listDonHangTemp = [];
    listDonHang.clear();
    await FirebaseFirestore.instance
        .collection('donHang').where("idLo", isEqualTo: loHang!.id)
        .get()
        .then((value) {
      final listData =
      value.docs.map<DonHang>((item) => DonHang.fromJson(item.data())).toList();
      listDonHangTemp.addAll(listData);

    });
    listDonHang.value =  listDonHangTemp.where((p0) => p0.trangThaiMen == TrangThai.daxacnhan || p0.trangThaiGa == TrangThai.daxacnhan).toList();
    listDonHang.refresh();
  }
  loadListTraHang() async {
    List<TraHang> listTraHangTemp = [];
    listTraHang.clear();
    await FirebaseFirestore.instance
        .collection('traHang').where("idLoHang", isEqualTo: loHang!.id)
        .get()
        .then((value) {
      final listData =
      value.docs.map<TraHang>((item) => TraHang.fromJson(item.data())).toList();
      listTraHangTemp.addAll(listData);

    });
    listTraHang.value =  listTraHangTemp;
    listTraHang.refresh();

  }

  RxNum getSoLuongGaTra(String idDonHang){
    RxNum soLuongGaTra = RxNum(0);
    for (var element in listTraHang) {
      if(element.idDonHang == idDonHang){
        soLuongGaTra.value += element.soGaXacNhan;
      }
    }
    soLuongGaTra.refresh();
    return soLuongGaTra;
  }
  RxNum getSoLuongMenTra(String idDonHang){
    RxNum soLuongMenTra =  RxNum(0);
    listTraHang.forEach((element) {
      if(element.idDonHang == idDonHang){
        print(element.soMenXacNhan);
        soLuongMenTra.value += element.soMenXacNhan;
      }
    });
    return soLuongMenTra;
  }
  onChange(){
    FirebaseFirestore.instance.collection("traHang").snapshots().listen((event) async {
      await loadListTraHang();

    });
  }
  onChangeDonHang(){
    FirebaseFirestore.instance.collection("donHang").snapshots().listen((event) async {
      await loadListDonHang();
    });
  }
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments != null){
      loHang = Get.arguments;
    }
    await onChangeDonHang();
    await onChange();
    print(listDonHang.length);
    print(listTraHang.length);
    print("listTraHang");
  }
}
