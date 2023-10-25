import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';

class DanhSachDonHangGiaCongLogic extends GetxController {

  RxList<DonHang> listDonHang = RxList();
  RxList<DonHang> listDH = RxList();


  loadListDonHang() async {
    List<DonHang> listTemp = [];
    listDonHang.clear();
    await FirebaseFirestore.instance
        .collection('donHang').where("idGiaCongMen", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final listData =
      value.docs.map<DonHang>((item) => DonHang.fromJson(item.data()));
      listTemp.addAll(listData);
    });
    listDonHang.value = listTemp;
    listDonHang.refresh();
  }
  //
  // listDHOfUser() async {
  //   String idUser =  FirebaseAuth.instance.currentUser!.uid;
  //   List<DonHang> listTemp = [];
  //   // for(var item in listLoHang) {
  //   //   listTemp = item.listDH.where((element) => element.idGiaCongGa == idUser).toList();
  //   // }
  //   listDH.value = listTemp;
  //   listDH.refresh();
  // }



  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadListDonHang();
    // await listDHOfUser();

    print(listDH.length);

  }


}
