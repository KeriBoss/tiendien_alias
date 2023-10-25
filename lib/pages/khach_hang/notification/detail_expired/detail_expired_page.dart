import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/notification.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailExpiredPage extends StatelessWidget {
  NotificationModel notification = Get.arguments;

  final oCcy = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(hintText: 'Chi tiết thông báo'),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                listViewBill(),
                // const SizedBox(height: 16,),
                // infoNotification(),
              ],
            ),
          )
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
            "Bill quá 24 giờ thanh toán",
            style: TextStyles.defaultStyle.medium,
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notification.listBill!.length,
            itemBuilder: (context, index) {
              BillModel bill = notification.listBill![index];
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
                      "Đơn ${index + 1} - ${bill.id}",
                      style: TextStyles.defaultStyle.setTextSize(12),
                    ),
                    Row(
                      children: [
                        Text(
                          oCcy.format(bill.priceBill),
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
            "Số điểm nạp",
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
                "${notification.typeNotification == TypeNotification.buyPoints ? '+' : '-'}"
                "${oCcy.format(notification.price)}",
                style: TextStyles.defaultStyle
                    .setColor(notification.typeNotification ==
                            TypeNotification.buyPoints
                        ? const Color(0xff62C196)
                        : ColorPalette.errorColor)
                    .setTextSize(24)
                    .semiBold,
              ),
              Text(
                ' point',
                style: TextStyles.defaultStyle.setTextSize(16).medium,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget infoNotification() {
    Color colorGrey = const Color(0xffA4A4A4);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
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
                  notification.id,
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
                  "Thời gian",
                  style: TextStyles.defaultStyle
                      .setTextSize(12)
                      .setColor(colorGrey),
                ),
                Text(
                  DateFormat('dd/MM/yyy').format(notification.createdDate),
                  style: TextStyles.defaultStyle.setTextSize(12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
