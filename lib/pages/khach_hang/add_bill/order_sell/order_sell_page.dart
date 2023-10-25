import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/pages/khach_hang/add_bill/add_bill_success/add_bill_success_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'order_sell_controller.dart';

class OrderSellPage extends StatelessWidget {
  var controller = Get.put(OrderSellController());
  final oCcy = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backGroundColor,
      body: Column(
        children: [
          AppBarWidget(
            hintText: 'Đặt bán',
          ),
          // Container(
          //   decoration: ColorPalette.boxDecoration,
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //         left: 16, top: 61, bottom: 20, right: 16),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         InkWell(
          //             onTap: () {
          //               Get.close(1);
          //               FocusManager.instance.primaryFocus!.unfocus();
          //             },
          //             child: const Icon(Icons.arrow_back)),
          //         //const SizedBox(width: 70,),
          //         Text('Đặt bán',
          //           style: TextStyles.defaultStyle.medium.setTextSize(18),
          //         ),
          //         const Icon(Icons.error_outline, size: 24,)
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: buildPointCustomer(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: headerTable(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: controller.listBill.map((e) => itemBill(e)).toList(),
            ),
          ),

          Container(
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: ColorPalette.whiteColor,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tổng tiền thực tế:",
                  style: TextStyles.defaultStyle.medium,
                ),
                Text(
                  "${oCcy.format(controller.totalPrice.value)} point",
                  style: TextStyles.defaultStyle.medium
                      .setColor(const Color(0xff91CD91)),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: ColorPalette.whiteColor,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Tổng tiền ",
                    style: TextStyles.defaultStyle.medium,
                  ),
                  TextSpan(
                    text: "(trừ hoa hồng):",
                    style: TextStyles.defaultStyle.setTextSize(12).italic,
                  ),
                ])),
                Text(
                  "${oCcy.format(controller.totalPricePercent.value)} point",
                  style: TextStyles.defaultStyle.medium
                      .setColor(const Color(0xff91CD91)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Đơn sẽ được hoàn lại nếu sau 24h chưa có ai thanh toán",
            style: TextStyles.defaultStyle,
          )
        ],
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 6.h,
        margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 24),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.close(1);
              },
              child: Container(
                width: 30.w,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: ColorPalette.whiteColor,
                    border: Border.all()),
                child: Center(
                    child: Text(
                  "Hủy",
                  style: TextStyles.defaultStyle.setTextSize(16).medium,
                )),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: ButtonBlack(
                    hintText: 'Xác nhận',
                    onPressed: () {
                      controller.orderSell();
                    })),
          ],
        ),
      ),
    );
  }

  Widget buildPointCustomer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Image.asset(
            'assets/pngs/logo.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Điểm hiện có",
                style: TextStyles.defaultStyle.setTextSize(13),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/png/ic_money.png',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Obx(() {
                    return Text(
                      "${oCcy.format(controller.currentUser.value!.money)} point",
                      style: TextStyles.defaultStyle.setTextSize(13),
                    );
                  })
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  String formatCodeBill(String input) {
    if (input.length >= 2) {
      String prefix = input.substring(0, 2);
      String rest = input.substring(2);
      return '$prefix $rest';
    }
    return input;
  }

  Widget itemBill(BillModel bill) {
    num width = 100.w - 34;
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: width * 0.48,
              height: 60,
              padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
              decoration: const BoxDecoration(
                color: ColorPalette.whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Đơn: ${formatCodeBill(bill.id)}",
                    style: TextStyles.defaultStyle.medium.setTextSize(12),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Số lượng: ${bill.listBill.length} hoá đơn",
                    style: TextStyles.defaultStyle.setTextSize(12),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            Container(
              width: width * 0.3,
              height: 60,
              color: ColorPalette.whiteColor,
              child: Center(
                child: Text(
                  oCcy.format(bill.totalBill),
                  style: TextStyles.defaultStyle
                      .setTextSize(12)
                      .setColor(const Color(0xff62C196)),
                ),
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            Container(
              width: width * 0.22,
              height: 60,
              decoration: const BoxDecoration(
                color: ColorPalette.whiteColor,
              ),
              child: Center(
                child: Text(
                  "${bill.discountBill}%",
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

  Widget headerTable() {
    num width = 100.w - 34;
    return Row(
      children: [
        Container(
          width: width * 0.48,
          height: 40,
          decoration: const BoxDecoration(
              color: Color(0xffB1B1B1),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8))),
          child: Center(
            child: Obx(() {
              return Text(
                "Đơn hàng (${controller.totalBill.value} đơn)",
                style: TextStyles.defaultStyle.setTextSize(12),
              );
            }),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.3,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "Giá trị Bill",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.22,
          height: 40,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
            color: Color(0xffB1B1B1),
          ),
          child: Center(
            child: Text(
              "Phí %",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
      ],
    );
  }
}
