import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/data/dummy_data.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/historyPayment.dart';
import 'package:tiendien_alias/pages/admin/show_buy_bill/detail_bill/detail_bill_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'show_buy_bill_controller.dart';

class ShowBuyBillPage extends StatelessWidget {
  var controller = Get.put(ShowBuyBillController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(hintText: 'Xem bill thanh toán'),
            Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.listHistoryPayment.length,
                itemBuilder: (context, index) {
                  HistoryPayment historyPayment =
                      controller.listHistoryPayment[index];

                  return GestureDetector(
                      onTap: () {
                        Get.to(() => DetailBillPage(),
                            arguments: historyPayment);
                      },
                      child: itemBill(historyPayment));
                },
              );
            })
          ],
        ),
      ),
    );
  }

  Widget itemBill(HistoryPayment historyPayment) {
    num length = historyPayment.listElectricityBill
        .where((element) => element.isPayment == false)
        .length;
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 14, bottom: 15),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đơn 1 - ${historyPayment.listElectricityBill.first.codeBill}",
                  style: TextStyles.defaultStyle.medium.setTextSize(14),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 7,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("Giá trị đơn: ",
                        style: TextStyles.defaultStyle.setTextSize(12)),
                    Text("${oCcy.format(historyPayment.totalBill)} VND",
                        style: TextStyles.defaultStyle.setTextSize(12)),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 7,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("Người thanh toán: ",
                        style: TextStyles.defaultStyle.setTextSize(12)),
                    Text(historyPayment.nameUser!,
                        style: TextStyles.defaultStyle.setTextSize(12)),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 7,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("Trạng thái: ",
                        style: TextStyles.defaultStyle.setTextSize(12)),
                    getStatus(length),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          )
        ],
      ),
    );
  }

  static Widget getStatus(num status) {
    if (status > 0) {
      return Text(
        "Chờ thanh toán",
        style: TextStyles.defaultStyle
            .setTextSize(12)
            .setColor(const Color(0xffCA6D00)),
      );
    } else {
      return Text(
        "Đã thanh toán",
        style: TextStyles.defaultStyle
            .setTextSize(12)
            .setColor(const Color(0xff62C196)),
      );
    }
  }
}
