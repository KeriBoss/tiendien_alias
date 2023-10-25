import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/electricityBill.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/khach_hang/home_customer/home_customer_controller.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DetailBillPage extends StatelessWidget {
  BillModel billModel = Get.arguments;
  final oCcy = NumberFormat('#,##0', 'en_US');
  HomeCustomerController homeCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.backGroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(hintText: 'Hoá đơn của bạn'),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 22),
                color: ColorPalette.backGroundColor,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: ColorPalette.whiteColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, top: 16, bottom: 16),
                              child: infoBill(),
                            ),
                            Column(
                              children: [
                                billModel.listBillPaid.isNotEmpty
                                    ? headerTable()
                                    : Container(),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: billModel.listBillPaid.length,
                                  itemBuilder: (context, index) {
                                    ElectricityBillModel electricityBill =
                                        billModel.listBillPaid[index];
                                    return itemTable(electricityBill, index);
                                  },
                                ),
                                headerTable(),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: billModel.listBill.length,
                                  itemBuilder: (context, index) {
                                    ElectricityBillModel electricityBill =
                                        billModel.listBill[index];
                                    return itemTable(electricityBill, index);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: DateTime.now().difference(billModel.dateBill).inMinutes > 5
            ? Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(
                    bottom: 24, top: 16, left: 24, right: 24),
                width: MediaQuery.of(context).size.width,
                height: 6.h,
                child: Center(
                    child: ButtonBlack(
                        hintText: 'Hoàn đơn',
                        onPressed: () {
                          DiaLog.showDiaLogYN(
                              title: 'Thông báo',
                              content: 'Xác nhận hoàn lại đơn',
                              accept: () => returnBill());
                        })),
              )
            : Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(
                    bottom: 24, top: 16, left: 24, right: 24),
                width: MediaQuery.of(context).size.width,
                height: 1,
              ));
  }

  void returnBill() async {
    UserModel userModel = homeCustomerController.currentUser.value!;
    userModel.money = userModel.money + billModel.priceBill;
    await DatabaseProvider().editModel(
        collection: 'users', id: userModel.id, toJsonModel: userModel.toJson());

    billModel.status = Status.hoanBill;
    await DatabaseProvider()
        .editModel(
            collection: 'bill',
            id: billModel.id,
            toJsonModel: billModel.toJson())
        .whenComplete(() => Get.close(2));
  }

  Widget infoBill() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Đơn - ${billModel.id}",
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
            ColorPalette.getStatus(billModel.status),
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
            Text("${oCcy.format(billModel.totalBill)} VND",
                style: TextStyles.defaultStyle.setTextSize(12)),
          ],
        ),
      ],
    );
  }

  Widget headerTable() {
    return Row(
      children: [
        Container(
          width: 12.6.w,
          height: 40,
          color: const Color(0xffB1B1B1),
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
          width: 30.w,
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
          width: 24.4.w,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "Giá(000)",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: 33.w - 35,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "Trạng thái",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget itemTable(ElectricityBillModel electricityBill, int index) {
    index = index + 1;
    return Container(
      color: ColorPalette.backGroundColor,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12.6.w,
                height: 40,
                color: ColorPalette.whiteColor,
                child: Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: TextStyles.defaultStyle.setTextSize(12),
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Container(
                width: 30.w,
                height: 40,
                color: ColorPalette.whiteColor,
                child: Center(
                  child: Text(
                    "${electricityBill.codeBill.substring(0, 8)}...",
                    style: TextStyles.defaultStyle.setTextSize(12),
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Container(
                width: 24.4.w,
                height: 40,
                color: ColorPalette.whiteColor,
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
                width: 33.w - 35,
                height: 40,
                color: ColorPalette.whiteColor,
                child: Center(
                  child: electricityBill.isCheck
                      ? Text("Đã thanh toán",
                          textAlign: TextAlign.center,
                          style: TextStyles.defaultStyle
                              .setTextSize(12)
                              .setColor(const Color(0xff91CD91)))
                      : Text("Chưa thanh toán",
                          textAlign: TextAlign.center,
                          style: TextStyles.defaultStyle
                              .setTextSize(12)
                              .setColor(const Color(0xffD9D9D9))),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 1,
          ),
        ],
      ),
    );
  }
}
