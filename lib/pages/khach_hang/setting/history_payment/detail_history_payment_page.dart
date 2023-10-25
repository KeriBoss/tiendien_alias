import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/electricityBill.dart';
import 'package:tiendien_alias/models/historyPayment.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailHistoryPaymentPage extends StatelessWidget {
  HistoryPayment historyPayment = Get.arguments;
  final oCcy = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(hintText: 'Chi tiết giao dịch'),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: cardMoney(),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: listViewBill(),
          ),
          const SizedBox(
            height: 16,
          ),
          infoNotification(),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }

  Widget infoNotification() {
    num length = historyPayment.listElectricityBill
        .where((element) => element.isPayment == false)
        .length;
    Color colorGrey = const Color(0xffA4A4A4);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tình trạng",
                  style: TextStyles.defaultStyle
                      .setTextSize(12)
                      .setColor(colorGrey),
                ),
                Text(
                  length > 0 ? "Đang chờ thanh toán" : "Đã thanh toán",
                  style: TextStyles.defaultStyle.setTextSize(12),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mã giao dịch",
                  style: TextStyles.defaultStyle.setColor(colorGrey),
                ),
                Text(
                  historyPayment.id,
                  style: TextStyles.defaultStyle.setTextSize(12),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Thời gian",
                  style: TextStyles.defaultStyle
                      .setTextSize(12)
                      .setColor(colorGrey),
                ),
                Text(
                  DateFormat('dd/MM/yyy').format(historyPayment.createdDate),
                  style: TextStyles.defaultStyle.setTextSize(12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listViewBill() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 22, bottom: 24),
      decoration: BoxDecoration(
        color: ColorPalette.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chi tiết thanh toán",
            style: TextStyles.defaultStyle.medium,
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: historyPayment.listElectricityBill.length,
            itemBuilder: (context, index) {
              ElectricityBillModel electricityBill =
                  historyPayment.listElectricityBill[index];
              return Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorPalette.backGroundColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${index + 1}. ${electricityBill.codeBill}",
                      style: TextStyles.defaultStyle.setTextSize(12),
                    ),
                    Row(
                      children: [
                        Text(
                          oCcy.format(electricityBill.priceBill),
                          style: TextStyles.defaultStyle
                              .setTextSize(12)
                              .setColor(const Color(0xff91CD91)),
                        ),
                        Text(' VND',
                            style: TextStyles.defaultStyle.setTextSize(12)),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget cardMoney() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 26),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(
            "Số tiền thanh toán",
            style: TextStyles.defaultStyle
                .setTextSize(12)
                .setColor(const Color(0xffA4A4A4)),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "+${oCcy.format(historyPayment.totalBill)}",
                style: TextStyles.defaultStyle
                    .setColor(const Color(0xff62C196))
                    .setTextSize(24)
                    .semiBold,
              ),
              Text(
                ' VNĐ',
                style: TextStyles.defaultStyle.setTextSize(16).medium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
