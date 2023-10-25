import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:tiendien_alias/pages/khach_hang/market/pay_loading/pay_loading_page.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DetailBillPayController extends GetxController {
  BillModel bill = Get.arguments;
  RxString time = RxString('');
  Rxn<UserModel> currentUser = Rxn();
  DatabaseProvider databaseProvider = DatabaseProvider();
  HomeCustomerController homeCustomerController = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(bill.listBill.length);
    currentUser.value = homeCustomerController.currentUser.value;
    int remainingSeconds = bill.listBill.length * 120;
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;
    time.value =
        "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
  }

  handleBuyBill() async {
    // check money enough for buy bill
    if (currentUser.value!.money >=
        (bill.totalBill * (bill.discountBill / 100))) {
      num fee = bill.totalBill * (bill.discountBill / 100);
      currentUser.value!.money =
          currentUser.value!.money - fee; // tam giu point khi mua bill
      await databaseProvider.editModel(
          collection: 'users',
          id: currentUser.value!.id,
          toJsonModel: currentUser.value!.toJson());
      bill.userBuy = FirebaseAuth.instance.currentUser!.uid;
      bill.status = Status.daMuaBill;
      await databaseProvider.editModel(
          collection: 'bill', id: bill.id, toJsonModel: bill.toJson());

      Get.to(() => PayLoadingPage(), arguments: bill);
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
              padding: const EdgeInsets.symmetric(vertical: 10),
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
            height: 24,
          ),
        ],
      ),
    );
  }
}
