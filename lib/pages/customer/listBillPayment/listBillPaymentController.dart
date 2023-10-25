import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/MessagingService.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/electricityBill.dart';
import 'package:tiendien_alias/models/notificationModel.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ListBillPaymentController extends GetxController {
  BillModel bill = Get.arguments[1];
  RxInt second = RxInt(0);
  Timer? timer;
  RxBool isRefresh = RxBool(false);
  RxInt totalBillPaid = RxInt(0);
  RxDouble totalPriceBillPaid = RxDouble(0.0);
  MessagingService messagingService = MessagingService();
  UserModelProvider userModelProvider = UserModelProvider();
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  String resultCheck = "";
  Rxn<BillModel> billCurrent = Rxn<BillModel>();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    second.value = Get.arguments[0];
    startTimer();
    currentUser.value = await userModelProvider.getCurrentUser();
    await onChangeValueBill();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (second.value > 0) {
        second.value--;
      } else {
        if (second.value == 0) {
          Get.dialog(const AlertDialog(
            title: Text("Thông báo"),
            content: Text("Bạn đã hết thời gian để thanh toán"),
          ));
        }
        timer?.cancel();
      }
    });
  }

  Future<void> checkApiBill(String codeBill) async {
    try {
      String link = "https://chotool.net/api/dien/api2.php?madon=$codeBill";
      await http.get(Uri.parse(link)).then((value) {
        if (value.statusCode != 404) {
          if (value.body[0] == "1") {
            resultCheck = "Đã thanh toán";
          } else {
            resultCheck = "Chưa thanh toán";
          }
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  paidAllBill() async {
    DiaLog.showIndicatorDialog();
    bill.status = Status.billDaHoanThanh;
    await FirebaseFirestore.instance
        .collection('bill')
        .doc(bill.id)
        .update(bill.toJson())
        .then((value) async {
      // Notification
      final docNotifications =
          FirebaseFirestore.instance.collection('notifications').doc();
      NotificationModel notificationModel = NotificationModel(
        docNotifications.id,
        bill.byUser,
        FirebaseAuth.instance.currentUser!.uid,
        "Thông báo",
        "",
        "Bill của bạn đã được thanh toán vui lòng xác nhận",
        bill,
        DateTime.now(),
      );
      await docNotifications.set(notificationModel.toJson());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(bill.byUser)
          .get()
          .then((value) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        messagingService.sendPushNotification(
          title: "Thông báo",
          body: "Bill của bạn đã được thanh toán vui lòng xác nhận",
          token: data['token'],
          idNotification: notificationModel.id,
        );
      });

      //When 3 minutes customer claim money
      String chietKhau = (bill.discountBill + 0.22).toStringAsFixed(2);
      double doubleChietKhau = double.parse(chietKhau);
      double priceBillAfter =
          bill.totalBill - (bill.totalBill * doubleChietKhau / 100);
      Future.delayed(const Duration(minutes: 3)).then((value) async {
        if (billCurrent.value!.isPayment == false) {
          await FirebaseFirestore.instance
              .collection('bill')
              .doc(notificationModel.bill.id)
              .update({
            'isPayment': true,
          });
          notificationModel.descriptionNguoiNhan =
              "Bills của bạn đã được xác nhận";
          notificationModel.bill.isPayment = true;
          await FirebaseFirestore.instance
              .collection('notifications')
              .doc(notificationModel.id)
              .update(notificationModel.toJson());
          currentUser.value!.money = currentUser.value!.money + priceBillAfter;
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update(currentUser.value!.toJson());
        }
      });
      Get.close(1);
      timer?.cancel();
      Get.offAllNamed('/customer_home');
    });
  }

  paidBill(List<ElectricityBillModel> listDaThanhToan,
      List<ElectricityBillModel> listChuaThanhToan) async {
    DiaLog.showIndicatorDialog();
    bill.status = Status.choMuaBill;
    await FirebaseFirestore.instance
        .collection('bill')
        .doc(bill.id)
        .update(bill.toJson())
        .then((value) async {
      // Notification
      final docNotifications =
          FirebaseFirestore.instance.collection('notifications').doc();
      NotificationModel notificationModel = NotificationModel(
        docNotifications.id,
        bill.byUser,
        FirebaseAuth.instance.currentUser!.uid,
        "Thông báo",
        "",
        "Bill của bạn đã được thanh toán vui lòng xác nhận",
        bill,
        DateTime.now(),
      );
      await docNotifications.set(notificationModel.toJson());

      // send Notification
      await FirebaseFirestore.instance
          .collection('users')
          .doc(bill.byUser)
          .get()
          .then((value) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        messagingService.sendPushNotification(
          title: "Thông báo",
          body: "Bill của bạn đã được thanh toán vui lòng xác nhận",
          token: data['token'],
          idNotification: notificationModel.id,
        );
      });

      double totalBillDaThanhToan = 0.0;
      for (var item in listDaThanhToan) {
        totalBillDaThanhToan += item.priceBill;
      }

      double totalBillChuaThanhToan = 0.0;
      for (var item in listChuaThanhToan) {
        totalBillChuaThanhToan += item.priceBill;
      }
      bill.listBill = listChuaThanhToan;
      double priceBill = totalBillChuaThanhToan -
          (totalBillChuaThanhToan * bill.discountBill / 100);
      bill.priceBill = priceBill;
      bill.totalBill = totalBillChuaThanhToan;

      await FirebaseFirestore.instance
          .collection('bill')
          .doc(bill.id)
          .update(bill.toJson());

      //When 3 minutes customer claim money
      String chietKhau = (bill.discountBill + 0.22).toStringAsFixed(2);
      double doubleChietKhau = double.parse(chietKhau);
      double priceBillAfter =
          totalBillDaThanhToan - (totalBillDaThanhToan * doubleChietKhau / 100);
      Future.delayed(const Duration(minutes: 3)).then((value) async {
        if (billCurrent.value!.isPayment == false) {
          await FirebaseFirestore.instance
              .collection('bill')
              .doc(notificationModel.bill.id)
              .update({
            'isPayment': true,
          });
          notificationModel.descriptionNguoiNhan =
              "Bills của bạn đã được xác nhận";
          notificationModel.bill.isPayment = true;
          await FirebaseFirestore.instance
              .collection('notifications')
              .doc(notificationModel.id)
              .update(notificationModel.toJson());
          currentUser.value!.money = currentUser.value!.money + priceBillAfter;
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update(currentUser.value!.toJson());
        }
      });
      Get.close(1);
      timer?.cancel();
      Get.offAllNamed('/customer_home');
    });
  }

  checkAcceptMoney() async {
    if (bill != null) {
      await FirebaseFirestore.instance
          .collection("bill")
          .doc(bill.id)
          .get()
          .then((value) {
        if (value.exists) {
          billCurrent.value = BillModel.fromJson(value.data()!);
        }
      });
    }
  }

  onChangeValueBill() async {
    if (bill != null) {
      await FirebaseFirestore.instance
          .collection('bill')
          .snapshots()
          .listen((event) {
        checkAcceptMoney();
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    resultCheck = "";
    timer?.cancel();
    super.dispose();
  }
}
