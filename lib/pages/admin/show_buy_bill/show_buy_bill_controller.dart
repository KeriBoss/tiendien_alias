import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/historyPayment.dart';
import 'package:get/get.dart';

class ShowBuyBillController extends GetxController {
  RxList<BillModel> listBill = RxList();
  RxList<HistoryPayment> listHistoryPayment = RxList();
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await onChangeValue();
  }

  onChangeValue() async {
    FirebaseFirestore.instance
        .collection('historyPayment')
        .snapshots()
        .listen((event) async {
      await getListHistoryPayment();
    });
  }

  getBill() async {
    await FirebaseFirestore.instance
        .collection('bill')
        .where('listBillPaid', isNotEqualTo: [])
        .get()
        .then((value) {
          if (value.docs.isNotEmpty) {
            final allData =
                value.docs.map((e) => BillModel.fromJson(e.data())).toList();
            listBill.value = allData;
            listBill.refresh();
            print(listBill.length);
          }
        });
  }

  getListHistoryPayment() async {
    await FirebaseFirestore.instance
        .collection('historyPayment')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final allData =
            value.docs.map((e) => HistoryPayment.fromJson(e.data())).toList();
        allData.sort(
          (a, b) => b.createdDate.compareTo(a.createdDate),
        );
        listHistoryPayment.value = allData;
      }
    });
  }
}
