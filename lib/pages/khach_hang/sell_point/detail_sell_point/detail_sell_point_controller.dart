import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/localStorageService.dart';
import 'package:tiendien_alias/Sevice/local_auth_service.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/notification.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/khach_hang/sell_point/sell_point_controller.dart';
import 'package:tiendien_alias/pages/khach_hang/sell_point/sell_point_success/sell_point_success_page.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';

class DetailSellPointController extends GetxController {
  SellPointController sellPointController = Get.find();
  num money = Get.arguments[0];
  UserModel currentUser = Get.arguments[1];
  BankCustomer bankCustomer = Get.arguments[2];
  DatabaseProvider databaseProvider = DatabaseProvider();

  RxBool isCheck = RxBool(false);
  RxBool isValidator = RxBool(false);

  RxBool authenticated = RxBool(false);
  final _auth = LocalAuthentication();
  RxBool supportFaceID = RxBool(false);
  Timer? timer;
  RxInt seconds = RxInt(59);
  bool isFaceId = LocalStorageService.getValue('face_id') ?? true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (!kIsWeb) {
      _auth.isDeviceSupported().then((value) {
        supportFaceID.value = value;
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds.value--;
      } else {
        timer.cancel();
      }
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

  sellPoint() async {
    final docRutTien = FirebaseFirestore.instance.collection('napTien').doc();
    String id = docRutTien.id;
    DateTime now = DateTime.now();

    String code = randomNumber().toString();

    NotificationModel notification = NotificationModel(
        id: code,
        title: 'Giao dịch thành công',
        body: 'Bạn đã rút thành công',
        price: money,
        data: '',
        isView: false,
        byUser: FirebaseAuth.instance.currentUser!.uid,
        typeNotification: TypeNotification.withdrawPoints,
        typePrice: TypePrice.point,
        status: 'Chờ xử lý',
        sourceMoney: 'Ví Phoenix Pay',
        createdDate: now);
    await databaseProvider.addModel(
        collection: 'notification',
        id: notification.id,
        toJsonModel: notification.toJson());

    GiaoDichModel napTienModel = GiaoDichModel(
        id,
        code,
        currentUser.id,
        currentUser.name,
        bankCustomer.id,
        now,
        "",
        money.toString(),
        LoaiGiaoDich.rutTien,
        "Chờ xử lý",
        "");
    await docRutTien.set(napTienModel.toJson());

    currentUser.money = currentUser.money - money;

    await databaseProvider
        .editModel(
      collection: 'users',
      id: currentUser.id,
      toJsonModel: currentUser.toJson(),
    )
        .whenComplete(() {
      timer!.cancel();
      sellPointController.moneyController.clear();
      Get.off(() => SellPointSuccessPage(), arguments: [money, currentUser]);
    });
  }

  checkFaceID() async {
    if (supportFaceID.value) {
      final authenticate = await LocalAuth.authenticate();
      authenticated.value = authenticate;
      if (authenticated.value) {
        openDiaLog(Get.context!);
        sellPoint();
      } else {
        Get.defaultDialog(
            title: 'Thông báo',
            content: const Text('Face ID không hợp lệ, vui lòng thử lại'));
      }
    } else {
      Get.defaultDialog(
          title: 'Thông báo',
          content: const Text('Thiết bị này không hỗ trợ Face ID'));
    }
  }

  void openDiaLog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding:
                const EdgeInsets.only(top: 16, bottom: 19, left: 20, right: 20),
            decoration: BoxDecoration(
              color: ColorPalette.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/png/ic_reload.png',
                  width: 32,
                  height: 32,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Giao dịch sẽ được hoàn",
                  style: TextStyles.defaultStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "tất trong: ",
                      style: TextStyles.defaultStyle,
                    ),
                    Obx(() {
                      return Text(
                        "00:${seconds.value}",
                        style: TextStyles.defaultStyle
                            .setColor(const Color(0xff62C196)),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
