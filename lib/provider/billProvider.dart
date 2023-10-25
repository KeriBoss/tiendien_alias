import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bill.dart';

class BillProvider {
  Future<List<BillModel>> getAllBill([Status? status]) async {
    List<BillModel> list = [];
    if (status != null) {
      await FirebaseFirestore.instance
          .collection('bill')
          .where('status', isEqualTo: status.name)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          final allData =
              value.docs.map((e) => BillModel.fromJson(e.data())).toList();
          list = allData;
        } else {
          list = [];
        }
      });
    } else {
      await FirebaseFirestore.instance.collection('bill').get().then((value) {
        if (value.docs.isNotEmpty) {
          final allData =
              value.docs.map((e) => BillModel.fromJson(e.data())).toList();
          list = allData;
        } else {
          list = [];
        }
      });
    }

    return list;
  }

  Future<List<BillModel>> getAllBillById(String id) async {
    List<BillModel> list = [];
    await FirebaseFirestore.instance
        .collection('bill')
        .where('byUser', isEqualTo: id)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final allData =
            value.docs.map((e) => BillModel.fromJson(e.data())).toList();
        list = allData;
      } else {
        list = [];
      }
    });
    return list;
  }
}
