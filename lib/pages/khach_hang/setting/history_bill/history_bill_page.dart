import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/time_bill_payment.dart';
import 'package:tiendien_alias/pages/khach_hang/market/pay_loading/pay_loading_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'history_bill_controller.dart';

class HistoryBillPage extends StatelessWidget {
  var controller = Get.put(HistoryBillController());
  final oCcy = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(hintText: 'Bill đã mua'),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Obx(() {
              return controller.listBill.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.listBill.length,
                      itemBuilder: (context, index) {
                        BillModel bill = controller.listBill[index];
                        return GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection('timeBillPayment')
                                  .where('idBill', isEqualTo: bill.id)
                                  .where('byUser',
                                      isEqualTo: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .get()
                                  .then((value) {
                                if (value.docs.isNotEmpty) {
                                  TimeBillPaymentModel timeBillPayment =
                                      TimeBillPaymentModel.fromJson(
                                          value.docs.first.data());
                                  Get.to(() => PayLoadingPage(), arguments: [
                                    bill,
                                    timeBillPayment.timePayment
                                  ]);
                                } else {
                                  Get.to(() => PayLoadingPage(),
                                      arguments: bill);
                                }
                              });
                            },
                            child: itemBill(bill));
                      },
                    )
                  : Container();
            }),
          ),
        ],
      ),
    );
  }

  Widget itemBill(BillModel bill) {
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
                  "Đơn 1 - ${bill.id}",
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
                    Text(
                      "Trạng thái: ",
                      style: TextStyles.defaultStyle.setTextSize(12),
                    ),
                    Text(
                      "Chờ thanh toán",
                      style: TextStyles.defaultStyle
                          .setTextSize(12)
                          .setColor(const Color(0xffCA6D00)),
                    ),
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
                    Text("Giá trị đơn: ",
                        style: TextStyles.defaultStyle.setTextSize(12)),
                    Text("${oCcy.format(bill.totalBill)} VND",
                        style: TextStyles.defaultStyle.setTextSize(12)),
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
}
