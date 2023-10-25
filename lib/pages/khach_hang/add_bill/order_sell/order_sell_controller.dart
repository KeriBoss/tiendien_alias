import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/notification.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/khach_hang/add_bill/add_bill_success/add_bill_success_page.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OrderSellController extends GetxController {
  List<BillModel> listBill = Get.arguments;
  RxNum totalPrice = RxNum(0);
  RxNum totalPricePercent = RxNum(0);
  RxNum totalBill = RxNum(0);
  HomeCustomerController homeCustomerController = Get.find();
  DatabaseProvider databaseProvider = DatabaseProvider();
  Rxn<UserModel> currentUser = Rxn();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    calculation();
    currentUser.value = homeCustomerController.currentUser.value;
  }

  void calculation() {
    for (var item in listBill) {
      totalBill.value += item.listBill.length;
      totalPrice.value += item.totalBill;
      totalPricePercent.value +=
          (item.totalBill - (item.totalBill * (item.discountBill / 100)));
      item.priceBill =
          (item.totalBill - (item.totalBill * (item.discountBill / 100)));
    }
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

  orderSell() async {
    num moneyUser = currentUser.value!.money;
    if (moneyUser > totalPricePercent.value) {
      DiaLog.showIndicatorDialog();
      currentUser.value!.money = moneyUser - totalPricePercent.value;
      await databaseProvider.editModel(
          collection: 'users',
          id: currentUser.value!.id,
          toJsonModel: currentUser.value!.toJson());

      for (var item in listBill) {
        await databaseProvider.addModel(
            collection: 'bill', id: item.id, toJsonModel: item.toJson());

        // create notification
        String code = randomNumber().toString();
        NotificationModel notification = NotificationModel(
          id: code,
          title: 'Giao dịch thành công',
          body: 'Thanh toán thành công số tiền',
          price: item.priceBill,
          data: '',
          bill: item,
          isView: false,
          byUser: FirebaseAuth.instance.currentUser!.uid,
          typeNotification: TypeNotification.sellBill,
          typePrice: TypePrice.vnd,
          status: 'Thành công',
          sourceMoney: 'Ví Phoenix Pay',
          createdDate: DateTime.now(),
        );
        await databaseProvider.addModel(
            collection: 'notification',
            id: notification.id,
            toJsonModel: notification.toJson());
      }

      Get.close(1);
      Get.to(() => AddBillSuccessPage());
    } else {
      Get.bottomSheet(showBottomError());
    }
  }

  showBottomError() {
    return Container(
      decoration: const BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 37, bottom: 24),
            child: Image.asset(
              'assets/png/ic_sad.png',
              width: 60,
              height: 60,
            ),
          ),
          Text(
            "Lỗi giao dịch",
            style: TextStyles.defaultStyle.medium
                .setTextSize(18)
                .setColor(ColorPalette.errorColor),
          ),
          const SizedBox(
            height: 9,
          ),
          const Text(
            "Không đủ số dư trong ví, vui lòng nạp thêm để\ntiếp tục quá trình thanh toán",
            style: TextStyles.defaultStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 37,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonBlack(
              hintText: 'Nạp ngay',
              onPressed: () {
                Get.offAllNamed('/bottomNavBarCustomer');
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              Get.offAllNamed('/bottomNavBarCustomer');
            },
            child: Container(
              width: 100.w,
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: ColorPalette.whiteColor,
                  border: Border.all(color: ColorPalette.blackColor)),
              child: Center(
                  child: Text(
                "Huỷ giao dịch",
                style: TextStyles.defaultStyle.medium,
              )),
            ),
          ),
          const SizedBox(
            height: 37,
          ),
        ],
      ),
    );
  }
}
