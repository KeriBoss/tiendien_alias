import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Models/TraHang.dart';

class DanhSachDonHangGiaCongLogic extends GetxController {
  
  RxList<DonHang> listDonHang = RxList();
  RxList<DonHang> listDH = RxList();
  RxList<TraHang> listTraHang = RxList();


  loadListDonHang() async {
    List<DonHang> listTemp = [];
    listDonHang.clear();
    await FirebaseFirestore.instance
        .collection('donHang').where("idGiaCongGa", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final listData = value.docs.map<DonHang>((item) => DonHang.fromJson(item.data()));
      listTemp.addAll(listData);
    });
    listDonHang.value = listTemp;
    listDonHang.refresh();
  }
  loadListTraHang() async {
    List<TraHang> listTraHangTemp = [];
    listTraHang.clear();
    await FirebaseFirestore.instance
        .collection('traHang')
        .get()
        .then((value) {
      final listData =
      value.docs.map<TraHang>((item) => TraHang.fromJson(item.data()));
      listTraHangTemp.addAll(listData);
    });
    listTraHang.value = listTraHangTemp;
    listTraHang.refresh();
  }
  onChange() async {
    await FirebaseFirestore.instance.collection("traHang").snapshots().listen((event) async {
      await loadListTraHang();
    });
  }
  //
  // listDHOfUser() async {
  //   String idUser =  FirebaseAuth.instance.currentUser!zz.uid;
  //   List<DonHang> listTemp = [];
  //   // for(var item in listLoHang) {
  //   //   listTemp = item.listDH.where((element) => element.idGiaCongGa == idUser).toList();
  //   // }
  //   listDH.value = listTemp;
  //   listDH.refresh();
  // }

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


  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadListDonHang();
    await onChange();
    // await listDHOfUser();

    print(listDH.length);

  }


}
