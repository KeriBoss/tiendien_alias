import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/electricityBill.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'detail_bill_controller.dart';

class DetailBillPage extends StatelessWidget {
  var controller = Get.put(DetailBillPayController());
  final oCcy = NumberFormat("#,##0", 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildInfoUser(),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Get.close(1);
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Chi tiết hóa đơn",
                    style: TextStyles.defaultStyle.medium,
                  ),
                ],
              ),
            ),
            buildDetailBill(),
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 5.h,
        margin: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 24),
        child: ButtonBlack(
            hintText: 'Xác nhận',
            onPressed: () {
              print(controller.bill.listBill.length);
              Get.bottomSheet(showBottomSheetSaveMoney());
            }),
      ),
    );
  }

  Widget showBottomSheetSaveMoney() {
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
          SizedBox(
            height: 5.h,
          ),
          Image.asset(
            'assets/png/ic_icon.png',
            width: 66,
            height: 66,
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Số point tạm giữ: ",
                style: TextStyles.defaultStyle.setTextSize(18).medium,
              ),
              Text(
                oCcy.format(controller.bill.totalBill *
                    (controller.bill.discountBill / 100)),
                style: TextStyles.defaultStyle
                    .setTextSize(18)
                    .medium
                    .setColor(const Color(0xff90CD90)),
              ),
              Text(
                " point",
                style: TextStyles.defaultStyle.setTextSize(18).medium,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "*Lưu ý phí tối thiểu cho giao dịch này là 10%",
            style: TextStyles.defaultStyle
                .setTextSize(12)
                .setColor(ColorPalette.errorColor),
          ),
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonBlack(
              hintText: 'Xác nhận',
              onPressed: () {
                Get.close(1);
                controller.handleBuyBill();
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              Get.close(1);
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
                "Hủy giao dịch",
                style: TextStyles.defaultStyle.medium,
              )),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget buildDetailBill() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          info(),
          headerTable(),
          // listview
          controller.bill.listBill.length > 8
              ? SizedBox(
                  height: 35.h,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: controller.bill.listBill.length,
                    itemBuilder: (context, index) {
                      ElectricityBillModel electricityBill =
                          controller.bill.listBill[index];
                      return itemTable(electricityBill, index);
                    },
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: controller.bill.listBill.length,
                  itemBuilder: (context, index) {
                    ElectricityBillModel electricityBill =
                        controller.bill.listBill[index];
                    return itemTable(electricityBill, index);
                  },
                ),
          timePayment(),
        ],
      ),
    );
  }

  Widget timePayment() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorPalette.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/png/ic_clock.png',
            width: 28,
            height: 28,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            "Thời gian thanh toán: ",
            style: TextStyles.defaultStyle.setTextSize(12),
          ),
          Obx(() {
            return Text(
              controller.time.value,
              style: TextStyles.defaultStyle
                  .setColor(const Color(0xff62C196))
                  .setTextSize(12),
            );
          }),
        ],
      ),
    );
  }

  Widget headerTable() {
    num width = 100.w - 36;
    return Row(
      children: [
        Container(
          width: width * 0.16,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xffB1B1B1),
          ),
          child: Center(
            child: Text(
              "STT",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.28,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "Mã hoá đơn",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.28,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xffB1B1B1),
          ),
          child: Center(
            child: Text(
              "Số tiền",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.28,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xffB1B1B1),
          ),
          child: Center(
            child: Text(
              "Phí giao dịch",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget itemTable(ElectricityBillModel electricityBill, int index) {
    int stt = index + 1;
    num width = 100.w - 36;
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: width * 0.16,
              height: 40,
              decoration: const BoxDecoration(
                color: ColorPalette.whiteColor,
              ),
              child: Center(
                child: Text(
                  stt.toString().padLeft(2, '0'),
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            Container(
              width: width * 0.28,
              height: 40,
              color: ColorPalette.whiteColor,
              child: Center(
                child: Text(
                  "${electricityBill.codeBill.substring(0, 6)}...",
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            Container(
              width: width * 0.28,
              height: 40,
              decoration: const BoxDecoration(
                color: ColorPalette.whiteColor,
              ),
              child: Center(
                child: Text(
                  oCcy.format(electricityBill.priceBill),
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            Container(
              width: width * 0.28,
              height: 40,
              decoration: const BoxDecoration(
                color: ColorPalette.whiteColor,
              ),
              child: Center(
                child: Text(
                  "${controller.bill.discountBill}%",
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 1,
        ),
      ],
    );
  }

  Widget info() {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(8), topLeft: Radius.circular(8)),
        color: ColorPalette.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/png/ic_user.png',
                ),
                maxRadius: 16,
                backgroundColor: ColorPalette.backGroundColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                controller.bill.gender == 'Nam'
                    ? "Mr ${controller.bill.username}"
                    : "Mrs ${controller.bill.username}",
                style: TextStyles.defaultStyle.medium,
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            "ID: ${controller.bill.byUser.substring(0, 9)}",
            style: TextStyles.defaultStyle,
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              const Text(
                "Tổng tiền: ",
                style: TextStyles.defaultStyle,
              ),
              Text(
                oCcy.format(controller.bill.totalBill),
                style: TextStyles.defaultStyle.medium
                    .setColor(const Color(0xffF6B940)),
              ),
              const Text(
                " VNĐ",
                style: TextStyles.defaultStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              const Text(
                "Tổng phí: ",
                style: TextStyles.defaultStyle,
              ),
              Text(
                oCcy.format(controller.bill.totalBill *
                    (controller.bill.discountBill / 100)),
                style: TextStyles.defaultStyle.medium
                    .setColor(const Color(0xff91CD91)),
              ),
              const Text(
                " point",
                style: TextStyles.defaultStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfoUser() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 20),
      width: 100.w,
      decoration: const BoxDecoration(
          color: ColorPalette.blackColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      child: Row(
        children: [
          Image.asset(
            'assets/png/avatar.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        controller
                            .homeCustomerController.currentUser.value!.name,
                        style: TextStyles.defaultStyle.medium
                            .setTextSize(16)
                            .whiteTextColor,
                      );
                    }),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(() {
                      return cardMoney(controller
                          .homeCustomerController.currentUser.value!.money);
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardMoney(num money) {
    return Container(
      padding: const EdgeInsets.only(left: 6, right: 10, top: 4, bottom: 4),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Image.asset(
            'assets/png/ic_money.png',
            width: 14,
            height: 14,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            "${oCcy.format(money)} Point",
            style: TextStyles.defaultStyle.setTextSize(12),
          )
        ],
      ),
    );
  }
}
