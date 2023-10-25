import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/Sevice/MessagingService.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/electricityBill.dart';
import 'package:tiendien_alias/models/historyPayment.dart';
import 'package:tiendien_alias/models/time_bill_payment.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:tiendien_alias/pages/khach_hang/market/complete_payment/complete_payment_page.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:tiendien_alias/widgets/button_white.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart';

class PayLoadingController extends GetxController {
  RxString time = "00:00".obs;
  Rxn<BillModel> bill = Rxn();
  Timer? timer;
  Timer? timerPayment;
  DatabaseProvider databaseProvider = DatabaseProvider();
  final oCcy = NumberFormat("#,##0", 'en_US');
  HomeCustomerController homeCustomerController = Get.find();
  UserModel? userModel;
  UserModelProvider userProvider = UserModelProvider();
  bool isShowDiaLog = true;
  int timeRun = 0;
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    print(Get.arguments.runtimeType);

    if (Get.arguments.runtimeType.toString() == 'BillModel') {
      bill.value = Get.arguments;
      int remainingSeconds = bill.value!.listBill
              .where((element) => element.isCheck == false)
              .length *
          120;
      timeRun = remainingSeconds;
      int minutes = remainingSeconds ~/ 60;
      int seconds = remainingSeconds % 60;
      time.value =
          "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
    } else {
      bill.value = Get.arguments[0];
      int remainingSeconds = Get.arguments[1];
      timeRun = remainingSeconds;
      int minutes = remainingSeconds ~/ 60;
      int seconds = remainingSeconds % 60;
      time.value =
          "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
    }

    showPaymentTips();
    userModel = await userProvider.getCurrentUser();
  }

  void showPaymentTips() async {
    await Future.delayed(Duration.zero, () {
      Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/png/ic_light.png',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Mẹo thanh toán",
                    style: TextStyles.defaultStyle.medium
                        .setColor(const Color(0xff91CD91)),
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                "Để việc thanh toán của bạn trở nên đơn giản hơn,\nvui lòng thực hiện theo 3 bước sau:",
                style: TextStyles.defaultStyle.setTextSize(12),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorPalette.blackColor),
                            shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            "1",
                            style: TextStyles.defaultStyle.setTextSize(12),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 12.h + 2,
                        color: ColorPalette.blackColor,
                      ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorPalette.blackColor),
                            shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            "2",
                            style: TextStyles.defaultStyle.setTextSize(12),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 12.h + 2,
                        color: ColorPalette.blackColor,
                      ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorPalette.blackColor),
                            shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            "3",
                            style: TextStyles.defaultStyle.setTextSize(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 19,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chụp ảnh màn hình giao dịch\nkhi hoàn thành từng giao dịch",
                        style: TextStyles.defaultStyle.setTextSize(12),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Image.asset(
                        'assets/png/payment_success.png',
                        width: 48.w,
                        height: 7.h,
                      ),
                      const SizedBox(
                        height: 33,
                      ),
                      Text(
                        "Tải ảnh vừa chụp lên app\nPhoenix Pay",
                        style: TextStyles.defaultStyle.setTextSize(12),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Image.asset(
                        'assets/png/up_payment.png',
                        width: 48.w,
                        height: 7.h,
                      ),
                      const SizedBox(
                        height: 33,
                      ),
                      Text(
                        "Ấn nút “Tải lại” để hệ thống cập\nnhật trạng thái",
                        style: TextStyles.defaultStyle.setTextSize(12),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Image.asset(
                        'assets/png/reload_bill.png',
                        width: 48.w,
                        height: 7.h,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: ButtonBlack(
                  hintText: 'Tiếp theo',
                  onPressed: () {
                    Get.close(1);
                    startTimer();
                  }),
            ),
          ],
        ),
      );
    });
  }

  void startTimer() async {
    const duration = Duration(seconds: 1);
    int remainingSeconds = 0;
    await FlutterIsolate.runningIsolates;
    if (Get.arguments.runtimeType.toString() == 'BillModel') {
      remainingSeconds = bill.value!.listBill.length * 120;
    } else {
      remainingSeconds = Get.arguments[1];
    }

    timer = Timer.periodic(duration, (timer) async {
      if (remainingSeconds == 0) {
        time.value = "00:00";
        timer.cancel();
        if (isShowDiaLog) {
          showResultTimeOut();
        }
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconds--;
      }
    });
    timerPayment = Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        await FirebaseFirestore.instance
            .collection('timeBillPayment')
            .where('idBill', isEqualTo: bill.value!.id)
            .where('byUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) async {
          if (value.docs.isEmpty) {
            String id = FirebaseFirestore.instance
                .collection('timeBillPayment')
                .doc()
                .id;
            TimeBillPaymentModel timeBillPaymentModel = TimeBillPaymentModel(
                id: id,
                timePayment: remainingSeconds,
                idBill: bill.value!.id,
                byUser: FirebaseAuth.instance.currentUser!.uid);
            await databaseProvider.addModel(
                collection: 'timeBillPayment',
                id: id,
                toJsonModel: timeBillPaymentModel.toJson());
          } else {
            TimeBillPaymentModel timeBillPaymentModel =
                TimeBillPaymentModel.fromJson(value.docs.first.data());
            timeBillPaymentModel.timePayment = remainingSeconds;
            await databaseProvider.editModel(
                collection: 'timeBillPayment',
                id: timeBillPaymentModel.id,
                toJsonModel: timeBillPaymentModel.toJson());
          }
        });
      }
    });
  }

  Future<void> showResultTimeOut() async {
    List<ElectricityBillModel> listNotPayment = bill.value!.listBill
        .where((element) => element.isCheck == false)
        .toList();
    List<ElectricityBillModel> listPayment = bill.value!.listBill
        .where((element) => element.isCheck == true)
        .toList();

    num totalPayment = bill.value!.listBill
        .where((element) => element.isCheck == true)
        .fold(0, (previousValue, element) => previousValue + element.priceBill);
    num totalNotPayment = bill.value!.listBill
        .where((element) => element.isCheck == false)
        .fold(0, (previousValue, element) => previousValue + element.priceBill);

    await Future.delayed(Duration.zero, () {
      Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Điều chỉnh góc bo tròn ở đây
          ),
          content: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Đã hết thời gian thanh toán",
                    style: TextStyles.defaultStyle.setTextSize(16).medium,
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  SizedBox(
                    width: 100.w,
                    height: 40 * 5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: listNotPayment.length,
                      itemBuilder: (context, index) {
                        ElectricityBillModel electricityBill =
                            listNotPayment[index];
                        int stt = index + 1;
                        return Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 2),
                          decoration: BoxDecoration(
                              color: ColorPalette.backGroundColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$stt. ${electricityBill.codeBill}",
                                style: TextStyles.defaultStyle.setTextSize(12),
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        oCcy.format(electricityBill.priceBill),
                                    style: TextStyles.defaultStyle
                                        .setTextSize(12)
                                        .setColor(const Color(0xff91CD91))),
                                TextSpan(
                                    text: ' VND',
                                    style: TextStyles.defaultStyle
                                        .setTextSize(12)),
                              ]))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng đã thanh toán",
                        style: TextStyles.defaultStyle.setTextSize(12),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: oCcy.format(totalPayment),
                            style: TextStyles.defaultStyle
                                .setTextSize(12)
                                .setColor(const Color(0xff91CD91))),
                        TextSpan(
                            text: ' VND',
                            style: TextStyles.defaultStyle.setTextSize(12)),
                      ]))
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng chưa thanh toán",
                        style: TextStyles.defaultStyle.setTextSize(12),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: oCcy.format(totalNotPayment),
                            style: TextStyles.defaultStyle
                                .setTextSize(12)
                                .setColor(ColorPalette.errorColor)),
                        TextSpan(
                            text: ' VND',
                            style: TextStyles.defaultStyle.setTextSize(12)),
                      ]))
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                    onTap: () {
                      Get.close(1);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 18,
                    )),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
              child: ButtonBlack(
                  hintText: 'Xác nhận',
                  onPressed: () async {
                    // handle out time
                    if (totalPayment > 0) {
                      await handlePayment(totalNotPayment, listNotPayment,
                          totalPayment, listPayment);
                    } else {
                      await handleNotPayment();
                    }
                  }),
            ),
          ],
        ),
      );
    });
  }

  Future<void> showReturnBill() async {
    List<ElectricityBillModel> listNotPayment = bill.value!.listBill
        .where((element) => element.isCheck == false)
        .toList();
    List<ElectricityBillModel> listPayment = bill.value!.listBill
        .where((element) => element.isCheck == true)
        .toList();

    num totalPayment = bill.value!.listBill
        .where((element) => element.isCheck == true)
        .fold(0, (previousValue, element) => previousValue + element.priceBill);

    num totalNotPayment = bill.value!.listBill
        .where((element) => element.isCheck == false)
        .fold(0, (previousValue, element) => previousValue + element.priceBill);

    await Future.delayed(Duration.zero, () {
      Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Điều chỉnh góc bo tròn ở đây
          ),
          content: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Xác nhận hoàn đơn",
                    style: TextStyles.defaultStyle.setTextSize(16).medium,
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Bạn đã thanh toán",
                      style: TextStyles.defaultStyle.medium,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  listPayment.isNotEmpty
                      ? SizedBox(
                          width: 100.w,
                          height: 40 * 5,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: listNotPayment.length,
                            itemBuilder: (context, index) {
                              ElectricityBillModel electricityBill =
                                  listPayment[index];
                              int stt = index + 1;
                              return Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 2),
                                decoration: BoxDecoration(
                                    color: ColorPalette.backGroundColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "$stt. ${electricityBill.codeBill}",
                                      style: TextStyles.defaultStyle
                                          .setTextSize(12),
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: oCcy.format(
                                              electricityBill.priceBill),
                                          style: TextStyles.defaultStyle
                                              .setTextSize(12)
                                              .setColor(
                                                  const Color(0xff91CD91))),
                                      TextSpan(
                                          text: ' VND',
                                          style: TextStyles.defaultStyle
                                              .setTextSize(12)),
                                    ]))
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng đã thanh toán",
                        style: TextStyles.defaultStyle.setTextSize(12),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: oCcy.format(totalPayment),
                            style: TextStyles.defaultStyle
                                .setTextSize(12)
                                .setColor(const Color(0xff91CD91))),
                        TextSpan(
                            text: ' VND',
                            style: TextStyles.defaultStyle.setTextSize(12)),
                      ]))
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng chưa thanh toán",
                        style: TextStyles.defaultStyle.setTextSize(12),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: oCcy.format(totalNotPayment),
                            style: TextStyles.defaultStyle
                                .setTextSize(12)
                                .setColor(ColorPalette.errorColor)),
                        TextSpan(
                            text: ' VND',
                            style: TextStyles.defaultStyle.setTextSize(12)),
                      ]))
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                    onTap: () {
                      Get.close(1);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 18,
                    )),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonWhite(
                        hintText: 'Từ chối',
                        onPressed: () {
                          Get.close(1);
                        }),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ButtonBlack(
                        hintText: 'Xác nhận',
                        onPressed: () async {
                          // handle
                          timer!.cancel();
                          timerPayment!.cancel();
                          if (totalPayment > 0) {
                            await handlePayment(totalNotPayment, listNotPayment,
                                totalPayment, listPayment);
                          } else {
                            await handleNotPayment();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> handleNotPayment() async {
    DiaLog.showIndicatorDialog();

    num fee = bill.value!.totalBill * (bill.value!.discountBill / 100);

    homeCustomerController.currentUser.value!.money =
        homeCustomerController.currentUser.value!.money + (fee * 0.9);
    await databaseProvider.editModel(
        collection: 'users',
        id: homeCustomerController.currentUser.value!.id,
        toJsonModel: homeCustomerController.currentUser.value!.toJson());
    await deleteTimeBillPayment();
    bill.value!.userBuy = '';
    bill.value!.status = Status.choMuaBill;
    await databaseProvider
        .editModel(
            collection: 'bill',
            id: bill.value!.id,
            toJsonModel: bill.value!.toJson())
        .whenComplete(() {
      Get.close(1);

      Get.to(() => CompletePaymentPage());
    });
  }

  Future<void> handlePayment(
      num totalNotPayment,
      List<ElectricityBillModel> listNotPayment,
      num totalPayment,
      List<ElectricityBillModel> listPayment) async {
    if (totalNotPayment == 0) {
      handleAllPayment();
    } else {
      DiaLog.showIndicatorDialog();
      num feePerBill =
          (bill.value!.totalBill * (bill.value!.discountBill / 100)) /
              bill.value!.listBill.length; // phí mỗi bill
      num fee = feePerBill *
          listNotPayment.length; // hoàn point những bill chưa thanh toán
      homeCustomerController.currentUser.value!.money =
          homeCustomerController.currentUser.value!.money + fee;
      await databaseProvider.editModel(
          collection: 'users',
          id: homeCustomerController.currentUser.value!.id,
          toJsonModel: homeCustomerController.currentUser.value!.toJson());
      String id = randomNumber().toString();

      HistoryPayment historyPayment = HistoryPayment(
          id: id,
          content: 'Thanh toán hóa đơn điện',
          monthYear: '${DateTime.now().month}/${DateTime.now().year}',
          listElectricityBill: listPayment,
          totalBill: totalPayment,
          byUser: FirebaseAuth.instance.currentUser!.uid,
          nameUser: userModel!.name,
          createdDate: DateTime.now());
      await databaseProvider.addModel(
          collection: 'historyPayment',
          id: id,
          toJsonModel: historyPayment.toJson());
      await deleteTimeBillPayment();
      await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 0)
          .limit(1)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          final user = UserModel.fromJson(value.docs.first.data());
          if (user.token != '') {
            String body = "Có 1 đơn mới thanh toán, vui lòng kiểm tra";
            await MessagingService().sendNotification(
                title: 'Thông báo', body: body, token: user.token);
          }
        }
      });
      // remove bill payment
      bill.value!.status = Status.choMuaBill;
      bill.value!.priceBill = totalNotPayment -
          (totalNotPayment * (bill.value!.discountBill / 100));
      bill.value!.totalBill = totalNotPayment;
      bill.value!.userBuy = '';
      bill.value!.listBillPaid.addAll(listPayment);
      bill.value!.listBill = listNotPayment;
      print(bill.toJson());
      await databaseProvider
          .editModel(
              collection: 'bill',
              id: bill.value!.id,
              toJsonModel: bill.value!.toJson())
          .whenComplete(() {
        Get.close(1);
        Get.to(() => CompletePaymentPage());
      });
    }
  }

  deleteTimeBillPayment() async {
    await FirebaseFirestore.instance
        .collection('timeBillPayment')
        .where('idBill', isEqualTo: bill.value!.id)
        .where('byUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        TimeBillPaymentModel timeBillPayment =
            TimeBillPaymentModel.fromJson(value.docs.first.data());
        await databaseProvider.deleteModel(
            collection: 'timeBillPayment', idModel: timeBillPayment.id);
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

  Future<void> handleAllPayment() async {
    // get list not payment
    List<ElectricityBillModel> list = bill.value!.listBill
        .where((element) => element.isCheck == false)
        .toList();
    List<ElectricityBillModel> listPaid = bill.value!.listBill
        .where((element) => element.isCheck == true)
        .toList();

    // check list is empty
    if (list.isEmpty) {
      // handle complete all payment
      timer!.cancel();
      timerPayment!.cancel();
      DiaLog.showIndicatorDialog(); // show DiaLog
      await deleteTimeBillPayment();
      String id = randomNumber().toString();

      HistoryPayment historyPayment = HistoryPayment(
          id: id,
          content: 'Thanh toán hóa đơn điện',
          monthYear: '${DateTime.now().month}/${DateTime.now().year}',
          listElectricityBill: bill.value!.listBill,
          totalBill: bill.value!.totalBill,
          byUser: FirebaseAuth.instance.currentUser!.uid,
          nameUser: userModel!.name,
          createdDate: DateTime.now());
      await databaseProvider.addModel(
          collection: 'historyPayment',
          id: id,
          toJsonModel: historyPayment.toJson());
      bill.value!.status = Status.billDaHoanThanh;
      bill.value!.totalBill = 0;
      bill.value!.listBillPaid.addAll(listPaid);
      bill.value!.listBill = [];
      await databaseProvider
          .deleteModel(collection: 'bill', idModel: bill.value!.id)
          .whenComplete(() {
        Get.close(1); // close DiaLog
        Get.to(() => CompletePaymentPage());
      });
    } else {
      Get.defaultDialog(
          title: 'Thông báo',
          content: Text(
            "Vẫn còn bill chưa thanh toán",
            style: TextStyles.defaultStyle.medium,
          ));
    }
  }

  reloadBill() async {
    await FirebaseFirestore.instance
        .collection('bill')
        .doc(bill.value!.id)
        .get()
        .then((value) {
      if (value.exists) {
        bill.value = BillModel.fromJson(value.data()!);
      }
    });
  }

  Future<void> returnUpBill(ElectricityBillModel electricityBill) async {
    DiaLog.showIndicatorDialog();
    // delete folder contains image
    await FirebaseStorage.instance
        .ref('Bill/${electricityBill.codeBill}')
        .listAll()
        .then((value) async {
      for (var item in value.items) {
        await FirebaseStorage.instance.ref(item.fullPath).delete();
      }
    });
    // update bill
    bill.value!.listBill
        .firstWhere((element) => element.codeBill == electricityBill.codeBill)
        .urlImage = '';
    bill.value!.listBill
        .firstWhere((element) => element.codeBill == electricityBill.codeBill)
        .isCheck = false;
    await databaseProvider.editModel(
      collection: 'bill',
      id: bill.value!.id,
      toJsonModel: bill.toJson(),
      numGetClose: 1,
    );
  }

  Future<void> handleUpBill(ElectricityBillModel electricityBill) async {
    String image = await pickerImage();
    if (image != "") {
      DiaLog.showIndicatorDialog();
      String urlImage = "";
      String nameImage = basename(image);
      final path = 'Bill/${electricityBill.codeBill}/$nameImage';
      final fileImage = File(image);
      var ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(fileImage);
      urlImage = (await ref.getDownloadURL()).toString();
      // update urlImage in bill
      bill.value!.listBill
          .firstWhere((element) => element.codeBill == electricityBill.codeBill)
          .urlImage = urlImage;
      bill.value!.listBill
          .firstWhere((element) => element.codeBill == electricityBill.codeBill)
          .isCheck = true;
      await databaseProvider.editModel(
        collection: 'bill',
        id: bill.value!.id,
        toJsonModel: bill.toJson(),
        numGetClose: 1,
      );
    }
  }

  Future<String> pickerImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return "";

      return pickedImage.path;
    } catch (e) {
      if (e is PlatformException) {
        print(e.toString());
      } else {
        print('An error occurred: $e');
      }
      return "";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    timerPayment!.cancel();
    isShowDiaLog = false;
    FlutterIsolate.current.kill();
    super.dispose();
  }
}
