import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/LoHang.dart';

class DanhSachLoLogic extends GetxController {
  RxList<LoHang> listLoHang = RxList();

  loadListDonHang() async {
    List<LoHang> listLoHangTemp = [];
    listLoHang.clear();
    await FirebaseFirestore.instance
        .collection('LoHang').orderBy("ngayGiao", descending: true)
        .get()
        .then((value) {
      final listData =
      value.docs.map<LoHang>((item) => LoHang.fromJson(item.data()));
      listLoHangTemp.addAll(listData);
    });
    listLoHang.value = listLoHangTemp;
    listLoHang.refresh();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadListDonHang();
  }
}