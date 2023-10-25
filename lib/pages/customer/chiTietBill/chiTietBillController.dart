import 'package:tiendien_alias/models/bill.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/userModel.dart';

class ListBillByUserController extends GetxController {
  RxList<BillModel> listBill = RxList<BillModel>();

  RxDouble totalBill = RxDouble(0.0);
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}
