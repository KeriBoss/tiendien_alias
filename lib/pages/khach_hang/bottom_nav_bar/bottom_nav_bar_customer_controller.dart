import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class BottomNavBarCustomerController extends GetxController {
  RxBool isNotification = RxBool(true);

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await onChangeNotification();
  }

  onChangeNotification() async {
    FirebaseFirestore.instance.collection('notification')
        .where('byUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots().listen((event) async {
      await FirebaseFirestore.instance.collection('notification')
          .where('byUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('isView', isEqualTo: false).limit(1).get().then((value) {
        if(value.docs.isNotEmpty) {
          isNotification.value = false;
        } else {
          isNotification.value = true;
        }
      });
    });
    print(isNotification);
  }
}