import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryBillController extends GetxController {
  RxList<BillModel> listBill = RxList();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getBill();
  }

  getBill() async {
    listBill.clear();
    await FirebaseFirestore.instance
        .collection('bill')
        .where('userBuy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('status', isEqualTo: Status.daMuaBill.name)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final allData =
            value.docs.map((e) => BillModel.fromJson(e.data())).toList();
        allData.sort(
          (a, b) => b.dateBill.compareTo(a.dateBill),
        );
        listBill.value = allData;
        listBill.refresh();
      }
    });
  }
}
