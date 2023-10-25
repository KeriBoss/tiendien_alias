import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/historyPayment.dart';
import 'package:get/get.dart';

class DetailBillController extends GetxController {
  Rxn<HistoryPayment> historyPayment = Rxn();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    historyPayment.value = Get.arguments;
    await onChangeValue();
  }

  onChangeValue() {
    FirebaseFirestore.instance
        .collection('historyPayment')
        .doc(historyPayment.value!.id)
        .snapshots()
        .listen((event) async {
      await getHistoryPayment();
    });
  }

  getHistoryPayment() async {
    await FirebaseFirestore.instance
        .collection('historyPayment')
        .doc(historyPayment.value!.id)
        .get()
        .then((value) {
      if (value.exists) {
        historyPayment.value = HistoryPayment.fromJson(value.data()!);
      }
    });
  }
}
