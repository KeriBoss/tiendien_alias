import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> listNotificationNew = RxList();
  RxList<NotificationModel> listNotificationOld = RxList();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await onChangeNew();
    await onChangeOld();
  }

  onChangeNew() async {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, 0, 0, 0);
    FirebaseFirestore.instance
        .collection('notification')
        .where('byUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('createdDate', isGreaterThan: dateTime)
        .snapshots()
        .listen((event) async {
      await getNotificationNew();
    });
  }

  onChangeOld() async {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, 0, 0, 0);
    FirebaseFirestore.instance
        .collection('notification')
        .where('byUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('createdDate', isLessThan: dateTime)
        .snapshots()
        .listen((event) async {
      await getNotificationOld();
    });
  }

  Future<void> getNotificationNew() async {
    listNotificationNew.clear();
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, 0, 0, 0);
    await FirebaseFirestore.instance
        .collection('notification')
        .where('byUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('createdDate', isGreaterThan: dateTime)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final allData = value.docs
            .map((e) => NotificationModel.fromJson(e.data()))
            .toList();
        allData.sort(
          (a, b) => b.createdDate.compareTo(a.createdDate),
        );
        listNotificationNew.value = allData;
        listNotificationNew.refresh();
      } else {}
    });
  }

  Future<void> getNotificationOld() async {
    listNotificationOld.clear();
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, 0, 0, 0);
    await FirebaseFirestore.instance
        .collection('notification')
        .where('byUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('createdDate', isLessThan: dateTime)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final allData = value.docs
            .map((e) => NotificationModel.fromJson(e.data()))
            .toList();
        allData.sort(
          (a, b) => b.createdDate.compareTo(a.createdDate),
        );
        listNotificationOld.value = allData;
        listNotificationOld.refresh();
      }
    });
  }
}
