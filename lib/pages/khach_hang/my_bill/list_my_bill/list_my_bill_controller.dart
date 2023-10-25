import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/provider/billProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ListMyBillController extends GetxController {
  RxList<BillModel> listBill = RxList();
  List<BillModel> listTemp = [];
  BillProvider billProvider = BillProvider();
  RxNum totalPage = RxNum(0);
  num perPage = 5;
  RxNum currentPage = RxNum(1);

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await onChange();
  }

  Future<void> onChange() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('bill')
        .where('byUser', isEqualTo: id)
        .snapshots()
        .listen((event) async {
      await getAllMyBill();
    });
  }

  Future<void> getAllMyBill() async {
    listTemp = await billProvider
        .getAllBillById(FirebaseAuth.instance.currentUser!.uid);
    listBill.value =
        listTemp.where((element) => element.status != Status.hoanBill).toList();
    listBill.sort(
      (a, b) => b.dateBill.compareTo(a.dateBill),
    );
    listBill.refresh();
  }
}
