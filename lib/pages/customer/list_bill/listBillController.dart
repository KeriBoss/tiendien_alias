import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListBillController extends GetxController {
  deleteBill(String id) async {
    await FirebaseFirestore.instance.collection('bill').doc(id).delete().then((value) => Get.back());
  }
}
