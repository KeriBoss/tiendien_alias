import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/historyPayment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

class HistoryPaymentController extends GetxController {
  RxList<HistoryPayment> listHistoryHistory = RxList();
  final groupedHistoryPayments =
      RxList<MapEntry<String, List<HistoryPayment>>>();
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getHistoryPayment();
  }

  getHistoryPayment() async {
    listHistoryHistory.clear();
    await FirebaseFirestore.instance
        .collection('historyPayment')
        .where('byUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final allData =
            value.docs.map((e) => HistoryPayment.fromJson(e.data())).toList();
        allData.sort(
          (a, b) => b.createdDate.compareTo(a.createdDate),
        );
        listHistoryHistory.value = allData;
        listHistoryHistory.refresh();
        groupedHistoryPayments.value = allData
            .groupListsBy((element) => element.monthYear)
            .entries
            .toList();
        groupedHistoryPayments.refresh();
      }
    });
  }

  handleData() {
    for (var item in groupedHistoryPayments) {
      print(item.key);
    }
  }
}
