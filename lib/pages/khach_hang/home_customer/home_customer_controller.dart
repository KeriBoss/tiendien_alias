import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/MessagingService.dart';
import 'package:tiendien_alias/firebase_options.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:tiendien_alias/models/banner.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/notification.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/provider/bankCustomerProvider.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCustomerController extends GetxController {
  BankCustomerProvider bankCustomerProvider = BankCustomerProvider();
  UserModelProvider userModelProvider = UserModelProvider();
  Rxn<BankCustomer> bankCustomer = Rxn();
  Rxn<UserModel> currentUser = Rxn();
  RxList<BannerModel> listBanner = RxList();
  MessagingService messagingService = MessagingService();
  String phoneSupport = "";
  RxNum totalBillExpired = RxNum(0);
  List<BillModel> listTemp = [];

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await getBillExpired();
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != '' && totalBillExpired.value > 0) {
      await messagingService.sendNotification(
          title: 'Thông báo',
          body: 'Bạn có $totalBillExpired đơn đã quá 24h chưa thành toán',
          token: token!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await messagingService.requestPermission();
    await messagingService.listenFCM();
    await messagingService.loadFCM();
    bankCustomer.value = await bankCustomerProvider
        .getBankCustomer(FirebaseAuth.instance.currentUser!.uid);
    await onChangeUser();
    await onChangeValue();
    await getPhoneSupport();
  }

  onChangeBankCustomer() async {
    FirebaseFirestore.instance
        .collection('bankCustomer')
        .where('idCustomer', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) async {
      bankCustomer.value = await bankCustomerProvider
          .getBankCustomer(FirebaseAuth.instance.currentUser!.uid);
    });
  }

  int randomNumber() {
    Random random = Random();
    // Generate a random number within the specified range
    int firstPart = random.nextInt(900000) + 100000;
    int secondPart = random.nextInt(900000) + 100000;
    // Concatenate the two parts to create a 12-digit number
    int random12DigitNumber = int.parse('$firstPart$secondPart');

    return random12DigitNumber;
  }

  Future<void> getBillExpired() async {
    await FirebaseFirestore.instance
        .collection('bill')
        .where('byUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('status', isEqualTo: Status.choMuaBill.name)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        final allData =
            value.docs.map((e) => BillModel.fromJson(e.data())).toList();
        // lay nhung bill qua 24h
        // listTemp = allData.where((element) => DateTime.now().difference(element.dateBill).inHours > 24).toList();
        listTemp = allData
            .where((element) =>
                DateTime.now().difference(element.dateBill).inMinutes > 4)
            .toList();

        if (listTemp.isNotEmpty) {
          NotificationModel notificationModel = NotificationModel(
              id: randomNumber().toString(),
              title: 'Thông báo',
              body: 'Bạn có ${listTemp.length} đơn đã quá 24h chưa thành toán',
              price: 0,
              data: '',
              listBill: listTemp,
              isView: false,
              byUser: FirebaseAuth.instance.currentUser!.uid,
              typeNotification: TypeNotification.expired,
              typePrice: TypePrice.nothing,
              status: '',
              sourceMoney: '',
              createdDate: DateTime.now());

          await DatabaseProvider().addModel(
              collection: 'notification',
              id: notificationModel.id,
              toJsonModel: notificationModel.toJson());
          totalBillExpired.value = listTemp.length;
          for (var item in listTemp) {
            print(item.dateBill);
          }
          print(listTemp.length);
        }
      }
    });
  }

  getBanner() async {
    await FirebaseFirestore.instance
        .collection('banner')
        .orderBy('createdDate', descending: true)
        .limit(4)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final allData =
            value.docs.map((e) => BannerModel.fromJson(e.data())).toList();
        listBanner.value = allData;
        listBanner.refresh();
      }
    });
  }

  onChangeValue() async {
    FirebaseFirestore.instance
        .collection('banner')
        .snapshots()
        .listen((event) async {
      await getBanner();
    });
  }

  onChangeUser() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) async {
      currentUser.value = await userModelProvider.getCurrentUser();
    });
  }

  openZalo() async {
    Uri url = Uri.parse('https://zalo.me/0797842160');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not zalo');
    }
  }

  getPhoneSupport() async {
    phoneSupport = "";
    await FirebaseFirestore.instance
        .collection('configContact')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final allData = value.docs.map((e) => e.data()).toList();

        String phone1 = allData.firstWhereOrNull(
                (element) => element['id'] == 'phone1')?['contact'] ??
            "";
        String phone2 = allData.firstWhereOrNull(
                (element) => element['id'] == 'phone2')?['contact'] ??
            "";
        String phone3 = allData.firstWhereOrNull(
                (element) => element['id'] == 'phone3')?['contact'] ??
            "";
        List<String> list = [phone1, phone2, phone3];
        phoneSupport = list.firstWhere((element) => element != '');
      }
    });
  }

  openPhone() async {
    String phone = phoneSupport;
    final url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
