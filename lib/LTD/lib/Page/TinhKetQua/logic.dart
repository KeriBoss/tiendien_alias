import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DinhMuc.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';

import '../../Models/TraHang.dart';

class TinhKetQuaLogic extends GetxController {
  RxList<DonHang> listDonHang = RxList();
  RxList<TraHang> listTraHang = RxList();
  Rxn<DonHang> donhang = Rxn();
  Rxn<DonHang> currentDH = Rxn();
  List list = [];
  RxList<DinhMuc> listDinhMuc = RxList<DinhMuc>();
  List<DinhMuc> listTemp = [];
  DinhMuc? selectedDichMuc;

  RxInt gaTra = RxInt(0);
  RxInt menTra = RxInt(0);
  RxInt boTra = RxInt(0);
  double soMDu = 0.0;

  // Định mức
  loadDinhMuc() async {
    listDinhMuc.clear();
    await FirebaseFirestore.instance
        .collection('DinhMuc')
        .get()
        .then((value) {
      final listData =
      value.docs.map<DinhMuc>((item) => DinhMuc.fromJson(item.data()));
      listTemp.addAll(listData);
    });
    listDinhMuc.value = listTemp;
    listDinhMuc.refresh();
  }
  loadDonHang() async {
    await FirebaseFirestore.instance
        .collection('donHang').doc(donhang.value!.id)
        .get()
        .then((value) {
          currentDH.value = DonHang.fromJson(value.data()!);
    });
  }
  loadListTraHang() async {
    List<TraHang> listTraHangTemp = [];
    listTraHang.clear();
    await FirebaseFirestore.instance
        .collection('traHang')
        .get()
        .then((value) {
      final listData =
      value.docs.map<TraHang>((item) => TraHang.fromJson(item.data())).toList();
      listTraHangTemp.addAll(listData);

    });
    listTraHang.value =  listTraHangTemp;
    listTraHang.refresh();
    print(listTraHang.length);

  }
  // RxNum getSoLuongMenTra(String idDonHang){
  //   RxNum soLuongMenTra =  RxNum(0);
  //   listTraHang.forEach((element) {
  //     if(element.idDonHang == idDonHang){
  //       soLuongMenTra.value += element.soMenXacNhan;
  //     }
  //   });
  //   return soLuongMenTra;
  // }
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadDinhMuc();
    if(Get.arguments != null){
      list = Get.arguments;
      donhang.value = list.first;
    }
    tinh();
    await FirebaseFirestore.instance.collection("donHang").doc().snapshots().listen((event) {
      loadDonHang();
    });
    // await getDataTraHang();
    await onChange();
    soMDu = donhang.value!.tongSoM - (selectedDichMuc!.soMGa + selectedDichMuc!.soMMen);
  }

  tinh() {
    listDinhMuc.sort((a, b) => b.soM.compareTo(a.soM));
    for(var item in listDinhMuc) {
      if(donhang.value!.tongSoM - item.soM > 0 ) {
        selectedDichMuc = item;
        break;
      }

    }
  }

  // getDataTraHang() async {
  //   await FirebaseFirestore.instance.collection("donHang")
  //       .doc(donhang.value!.id).collection("TraHang")
  //       .where("idUser", isEqualTo: donhang.value!.idGa).get().then((value) {
  //         final allData = value.docs.map((e) => e.data()).toList();
  //         for(var item in allData){
  //           gaTra += item['SoLuong'];
  //         }
  //   });
  //   await FirebaseFirestore.instance.collection("donHang")
  //       .doc(donhang.value!.id).collection("TraHang")
  //       .where("idUser", isEqualTo: donhang.value!.idMen).get().then((value) {
  //     final allData = value.docs.map((e) => e.data()).toList();
  //     for(var item in allData){
  //       menTra += item['SoLuong'];
  //     }
  //   });
  //   // await FirebaseFirestore.instance.collection("donHang")
  //   //     .doc(donhang.value!.id).collection("TraHang")
  //   //     .where("idUser", isEqualTo: donhang.value!.idGiaCongFull).get().then((value) {
  //   //   final allData = value.docs.map((e) => e.data()).toList();
  //   //   for(var item in allData){
  //   //     boTra += item['SoLuong'];
  //   //   }
  //   // });
  // }
  // loadListTraHang() async {
  //   List<TraHang> listTraHangTemp = [];
  //   listTraHang.clear();
  //   await FirebaseFirestore.instance
  //       .collection('traHang')
  //       .get()
  //       .then((value) {
  //     final listData =
  //     value.docs.map<TraHang>((item) => TraHang.fromJson(item.data()));
  //     listTraHangTemp.addAll(listData);
  //   });
  //   listTraHang.value = listTraHangTemp;
  //   listTraHang.refresh();
  // }
  onChange() async {
    await FirebaseFirestore.instance.collection("traHang").snapshots().listen((event) async {
      await loadListTraHang();
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
        soLuongMenTra.value += element.soMenXacNhan;
      }
    });
    return soLuongMenTra;
  }

}
