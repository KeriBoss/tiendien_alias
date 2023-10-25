import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/electricityBill.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/color_palette.dart';
import '../home_screen/home/homeController.dart';
import 'listBillPaymentController.dart';
import 'package:intl/intl.dart';

class ListBillPaymentPage extends StatefulWidget {
  const ListBillPaymentPage({Key? key}) : super(key: key);

  @override
  State<ListBillPaymentPage> createState() => _ListBillPaymentPageState();
}

class _ListBillPaymentPageState extends State<ListBillPaymentPage> {
  ListBillPaymentController controller = Get.put(ListBillPaymentController());
  final oCcy = NumberFormat("#,##0", "en_US");
  CustomerHomeViewController customerHomeViewController =
      Get.put(CustomerHomeViewController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => customerHomeViewController.onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách bills vừa mua'),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Obx(() {
                  return Text(
                    "Thời gian còn lại để thanh toán là : ${controller.second.value.toString()}",
                    style: TextStyles.defaultStyle,
                  );
                })),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () {
                                for (var item in controller.bill.listBill) {
                                  item.isCheck = false;
                                }
                                controller.totalBillPaid.value = 0;
                                controller.totalPriceBillPaid.value = 0.0;

                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.redAccent,
                                size: 30,
                              )),
                          IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () async {
                                DiaLog.showIndicatorDialog();
                                controller.totalBillPaid.value = 0;
                                controller.totalPriceBillPaid.value = 0;
                                for (var item in controller.bill.listBill) {
                                  await controller.checkApiBill(item.codeBill);
                                  if (controller.resultCheck ==
                                      "Đã thanh toán") {
                                    item.isCheck = true;
                                    controller.totalBillPaid.value += 1;
                                    controller.totalPriceBillPaid.value +=
                                        item.priceBill;
                                  }
                                }
                                Get.close(1);

                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.redAccent,
                                size: 30,
                              )),
                          Text(
                            "Check All\nBills Button",
                            style: TextStyles.defaultStyle.bold
                                .setColor(ColorPalette.orangeBoldColor),
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          border: TableBorder.all(
                              width: 2,
                              color: ColorPalette.primaryColor,
                              borderRadius: BorderRadius.circular(12)),
                          columns: [
                            DataColumn(
                                label: Expanded(
                                    child: Text("List đơn",
                                        textAlign: TextAlign.center,
                                        style: TextStyles.defaultStyle
                                            .setTextSize(15)))),
                            DataColumn(
                                label: Expanded(
                                    child: Text("Số tiền",
                                        textAlign: TextAlign.center,
                                        style: TextStyles.defaultStyle
                                            .setTextSize(15)))),
                            DataColumn(
                                label: Expanded(
                                    child: Text("Trạng \nthái",
                                        textAlign: TextAlign.center,
                                        style: TextStyles.defaultStyle
                                            .setTextSize(15)))),
                          ],
                          rows: controller.bill.listBill
                              .map((item) => DataRow(cells: [
                                    DataCell(Text(item.codeBill,
                                        style: TextStyles.defaultStyle
                                            .setTextSize(15))),
                                    DataCell(Text(
                                        "${oCcy.format(item.priceBill)} VNĐ",
                                        style: TextStyles.defaultStyle
                                            .setTextSize(15))),
                                    DataCell(Center(
                                        child: item.isCheck == true
                                            ? const Text(
                                                "Đã thanh \ntoán",
                                                style: TextStyles.defaultStyle,
                                                textAlign: TextAlign.center,
                                              )
                                            : IconButton(
                                                onPressed: () async {
                                                  DiaLog.showIndicatorDialog();
                                                  await controller.checkApiBill(
                                                      item.codeBill);
                                                  if (controller.resultCheck ==
                                                      "Đã thanh toán") {
                                                    setState(() {
                                                      item.isCheck = true;
                                                      controller.totalBillPaid
                                                          .value += 1;
                                                      controller
                                                              .totalPriceBillPaid
                                                              .value +=
                                                          item.priceBill;
                                                    });
                                                  }
                                                  Get.close(1);
                                                },
                                                icon: const Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                )))),
                                  ]))
                              .toList()),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () async {
                      String copyAll = "";
                      for (var item in controller.bill.listBill) {
                        copyAll += "${item.codeBill}\n";
                      }
                      Fluttertoast.showToast(
                          msg: "Sao chép thành công",
                          backgroundColor: ColorPalette.secondShadeColor,
                          fontSize: 16);
                      await Clipboard.setData(ClipboardData(text: copyAll));
                    },
                    child: Container(
                      height: 61,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorPalette.orangeBoldColor,
                      ),
                      child: Center(
                          child: Text(
                        "Copy \nAll",
                        style: TextStyles.defaultStyle.bold.whiteTextColor
                            .setTextSize(18)
                            .copyWith(height: 1.3),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DataTable(
                    border: TableBorder.all(
                        width: 2,
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12)),
                    columns: [
                      DataColumn(
                          numeric: true,
                          label: Text(
                            "Tổng bill đã \nthanh toán",
                            style: TextStyles.defaultStyle.setTextSize(15),
                            textAlign: TextAlign.center,
                          )),
                      DataColumn(
                          label: Expanded(
                        child: Text(
                          "Tổng tiền thành toán \nthành công",
                          style: TextStyles.defaultStyle.setTextSize(15),
                          textAlign: TextAlign.center,
                        ),
                      )),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Center(
                            child: Text(
                          "${controller.totalBillPaid.value}",
                          style: TextStyles.defaultStyle.setTextSize(15),
                        ))),
                        DataCell(Center(
                            child: Text(
                                "${oCcy.format(controller.totalPriceBillPaid.value)} VNĐ",
                                style:
                                    TextStyles.defaultStyle.setTextSize(15)))),
                      ]),
                    ]),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (controller.bill.listBill
                            .where((element) => element.isCheck == false)
                            .toList()
                            .isEmpty) {
                          controller.paidAllBill();
                        } else {
                          Get.snackbar(
                              "Thông báo", "Bạn vẫn còn bill chưa thanh toán",
                              colorText: Colors.red);
                        }
                      },
                      child: Container(
                        width: 45.w,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorPalette.primaryColor),
                        child: Center(
                          child: Text("Đã thành toán xong tất cả bills!",
                              style: TextStyles.defaultStyle.whiteTextColor,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        List<ElectricityBillModel> listDaThanhToan = controller
                            .bill.listBill
                            .where((element) => element.isCheck == true)
                            .toList();
                        List<ElectricityBillModel> listChuaThanhToan =
                            controller.bill.listBill
                                .where((element) => element.isCheck == false)
                                .toList();
                        controller.paidBill(listDaThanhToan, listChuaThanhToan);
                      },
                      child: Container(
                        width: 45.w,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorPalette.primaryColor),
                        child: Center(
                          child: Text("Hoàn những bill chưa thanh toán kịp",
                              style: TextStyles.defaultStyle.whiteTextColor,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
