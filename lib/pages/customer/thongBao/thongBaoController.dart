import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../../../models/notificationModel.dart';

class ThongBaoNVController extends GetxController {
  RxList<NotificationModel> listNotification = RxList<NotificationModel>();
  @override
  void onInit() async {
    // TODO: implement onInit
    await loadData();
    await onChangeValue();
    super.onInit();
  }

  loadData() async {
    listNotification.clear();
    List<NotificationModel> list = [];
    final classSnapshot = await FirebaseDatabase.instance
        .ref()
        .child('notification')
        .orderByChild("idNguoiNhan")
        .equalTo(FirebaseAuth.instance.currentUser!.uid)
        .get();
    for (var item in classSnapshot.children) {
      Map<String, dynamic> jsonValue = json.decode(json.encode(item.value));
      NotificationModel notification = NotificationModel.fromJson(jsonValue);
      list.add(notification);
      list.sort((a, b) => b.createdTime.compareTo(a.createdTime));
    }
    listNotification.value = list;
    listNotification.refresh();
  }

  onChangeValue() async {
    await FirebaseDatabase.instance
        .ref()
        .child('notification')
        .orderByChild("idNguoiGui")
        .equalTo(FirebaseAuth.instance.currentUser!.uid)
        .onValue
        .listen((event) {
      loadData();
    });
  }
}
