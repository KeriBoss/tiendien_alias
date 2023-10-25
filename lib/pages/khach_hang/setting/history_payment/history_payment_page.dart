import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/historyPayment.dart';
import 'package:tiendien_alias/pages/khach_hang/setting/history_payment/detail_history_payment_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'history_payment_controller.dart';

class HistoryPaymentPage extends StatelessWidget {
  var controller = Get.put(HistoryPaymentController());
  final oCcy = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        AppBarWidget(
          hintText: 'Lịch sử giao dịch',
        ),
        const SizedBox(
          height: 8,
        ),
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 24),
        //     child: Obx(() {
        //       return ListView.builder(
        //         padding: EdgeInsets.zero,
        //         shrinkWrap: true,
        //         itemCount: controller.listHistoryHistory.length,
        //         itemBuilder: (context, index) {
        //           HistoryPayment historyPayment = controller.listHistoryHistory[index];
        //           return InkWell(
        //               onTap: () {
        //                 Get.to(() => DetailHistoryPaymentPage(), arguments: historyPayment);
        //               },
        //               child: itemHistoryPayment(historyPayment)
        //           );
        //         },
        //       );
        //     }),
        //   ),
        // ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Obx(() {
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: controller.groupedHistoryPayments.length,
                itemBuilder: (context, index) {
                  final monthOfYear =
                      controller.groupedHistoryPayments[index].key;
                  final listInMonth =
                      controller.groupedHistoryPayments[index].value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "T$monthOfYear",
                        style: TextStyles.defaultStyle.medium,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listInMonth.length,
                        itemBuilder: (context, index) {
                          HistoryPayment historyPayment = listInMonth[index];
                          return InkWell(
                              onTap: () {
                                Get.to(() => DetailHistoryPaymentPage(),
                                    arguments: historyPayment);
                              },
                              child: itemHistoryPayment(historyPayment));
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  );
                },
              );
            }),
          ),
        ),
      ]),
    );
  }

  Widget itemHistoryPayment(HistoryPayment historyPayment) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            historyPayment.content,
            style: TextStyles.defaultStyle,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            DateFormat("HH:mm:ss - dd/MM/yyyy")
                .format(historyPayment.createdDate),
            style: TextStyles.defaultStyle.setTextSize(12),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            'Tổng tiền: ${oCcy.format(historyPayment.totalBill)}VND',
            style: TextStyles.defaultStyle.setTextSize(12),
          ),
        ],
      ),
    );
  }
}
