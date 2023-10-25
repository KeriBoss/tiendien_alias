import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/DinhMuc.dart';

class BangDinhMucLogic extends GetxController {
  RxList<DinhMuc> listDinhMuc = RxList<DinhMuc>();
  List<DinhMuc> listTemp = [];

  // Định mức
  loadData3() async {
    listDinhMuc.clear();
    await FirebaseFirestore.instance
        .collection('DinhMuc')
        .orderBy("soBo", descending: false)
        .get()
        .then((value) {
      final listData =
          value.docs.map<DinhMuc>((item) => DinhMuc.fromJson(item.data()));
      listTemp.addAll(listData);
    });
    listDinhMuc.value = listTemp;
    listDinhMuc.refresh();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadData3();
    print(listDinhMuc.length);
  }
}
