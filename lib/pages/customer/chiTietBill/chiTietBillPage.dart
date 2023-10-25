import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/widgets/future_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constants/color_palette.dart';
import '../../../constants/textstyle_ext.dart';
import '../../../models/bill.dart';
import '../listBillPayment/listBillPaymentPage.dart';
import 'chiTietBillController.dart';

class ListBillByUserPage extends StatelessWidget {
  ListBillByUserPage({super.key, required this.bill});
  final BillModel bill;
  final controller = Get.put(ListBillByUserController());
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    String chietKhau = (bill.discountBill + 0.22).toStringAsFixed(2);
    double doubleChietKhau = double.parse(chietKhau);
    double priceBillAfter =
        bill.totalBill - (bill.totalBill * doubleChietKhau / 100);

    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết bills điện')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Người up: ",
                    style: TextStyles.defaultStyle,
                  ),
                  GetUserName(bill.byUser),
                ],
              ),
              const SizedBox(height: 10),
              DataTable(
                  border: TableBorder.all(
                      width: 2,
                      color: ColorPalette.primaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  columns: const [
                    DataColumn(
                        numeric: true,
                        label: Expanded(
                          child: Text(
                            "Mã bill",
                            style: TextStyles.defaultStyle,
                            textAlign: TextAlign.center,
                          ),
                        )),
                    DataColumn(
                        label: Expanded(
                      child: Text(
                        "Số tiền",
                        style: TextStyles.defaultStyle,
                        textAlign: TextAlign.center,
                      ),
                    )),
                  ],
                  rows: bill.listBill
                      .map((item) => DataRow(cells: [
                            DataCell(Text(item.codeBill.substring(0, 8),
                                style:
                                    TextStyles.defaultStyle.setTextSize(15))),
                            DataCell(Text("${oCcy.format(item.priceBill)} VNĐ",
                                style:
                                    TextStyles.defaultStyle.setTextSize(15))),
                          ]))
                      .toList()),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Tổng : ${oCcy.format(bill.totalBill)} VNĐ",
                style: TextStyles.defaultStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Chiếu khấu: $chietKhau%",
                style: TextStyles.defaultStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Tiền sẽ hoàn vào ví sau khi thành: ${oCcy.format(priceBillAfter)} VNĐ",
                style: TextStyles.defaultStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: ElevatedButton(
                    child: const Text("Xác nhận mua bill"),
                    onPressed: () {
                      showAlertDiaLog();
                    },
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Chú ý. Bạn có 90s để thanh toán trên mỗi hóa đơn điện.\n"
                  "Tổng số hóa đơn hiện tại là ${controller.listBill.length}, "
                  "bạn có ${controller.listBill.length * 90}s để hoàn tất,\n"
                  "nếu không kịp, hóa đơn chưa thanh toán sẽ được trả về chợ!",
                  style: TextStyles.defaultStyle.setTextSize(14),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDiaLog() {
    Get.dialog(AlertDialog(
      title: Text("Thông báo"),
      titleTextStyle: TextStyles.defaultStyle
          .setTextSize(20)
          .setColor(ColorPalette.primaryColor),
      content: const Text("Bạn xác nhận mua bills này không?"),
      contentTextStyle: TextStyles.defaultStyle,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 51,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  "Huỷ",
                  style: TextStyles.defaultStyle.whiteTextColor.bold,
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Hide bill when buy bill
                bill.status = Status.daMuaBill;
                FirebaseFirestore.instance
                    .collection('bill')
                    .doc(bill.id)
                    .update(bill.toJson())
                    .then((value) {
                  Get.to(() => const ListBillPaymentPage(),
                      arguments: [bill.listBill.length * 90, bill]);
                });
              },
              child: Container(
                height: 51,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  "Xác nhận",
                  style: TextStyles.defaultStyle.whiteTextColor.bold,
                )),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
