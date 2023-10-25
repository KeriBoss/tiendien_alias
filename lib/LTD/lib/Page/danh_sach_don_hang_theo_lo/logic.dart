import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/DiaLog.dart';
import 'package:tiendien_alias/LTD/lib/Models/DinhMuc.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/LoHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/TraHang.dart';

class DanhSachDonHangTheoLoLogic extends GetxController {
  RxList<DonHang> listDonHang = RxList();
  Rxn<LoHang> lohang = Rxn();
  DinhMuc? selected;
  RxList<TraHang> listTraHang = RxList();


  loadDonHang() async {
    List<DonHang> listTemp = [];
    listDonHang.clear();
    await FirebaseFirestore.instance
        .collection('donHang').where("idLo", isEqualTo: lohang.value!.id)
        .get()
        .then((value) {
      final listData =
      value.docs.map<DonHang>((item) => DonHang.fromJson(item.data()));
      listTemp.addAll(listData);
    });
    listDonHang.value = listTemp;
    listDonHang.refresh();
  }

  loadListTraHang() async {
    List<TraHang> listTraHangTemp = [];
    listTraHang.clear();
    await FirebaseFirestore.instance
        .collection('traHang').where("idLoHang", isEqualTo: lohang.value!.id)
        .get()
        .then((value) {
      final listData =
      value.docs.map<TraHang>((item) => TraHang.fromJson(item.data())).toList();
      listTraHangTemp.addAll(listData);

    });
    listTraHang.value =  listTraHangTemp;
    listTraHang.refresh();
  }
  hoanTacDonHangGa(DonHang donHang){
    DiaLog.showIndicatorDialog();
    donHang.idGa = "";
    donHang.trangThaiGa = TrangThai.chuaco;
    FirebaseFirestore.instance.collection("donHang").doc(donHang.id).update(donHang.toJson()).whenComplete(() {
      Get.close(1);
    });
  }
  hoanTacDonHangMen(DonHang donHang){
    DiaLog.showIndicatorDialog();
    donHang.idMen = "";
    donHang.trangThaiMen = TrangThai.chuaco;
    FirebaseFirestore.instance.collection("donHang").doc(donHang.id).update(donHang.toJson()).whenComplete(() {
      Get.close(1);
    });
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

  onChange() async {
    await FirebaseFirestore.instance.collection("donHang").snapshots().listen((event) {
      loadDonHang();
    });
  }
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments != null){
      lohang.value = Get.arguments;
      //listDonHang.value = lohang.value!.listDH;
    }
    await onChange();
    await loadListTraHang();
  }

}
