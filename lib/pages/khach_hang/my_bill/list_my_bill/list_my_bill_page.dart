import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/pages/khach_hang/add_bill/add_bill_page.dart';
import 'package:tiendien_alias/pages/khach_hang/my_bill/detail_my_bill/detail_my_bill_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'list_my_bill_controller.dart';

class ListMyBillPage extends StatelessWidget {
  var controller = Get.put(ListMyBillController());
  final oCcy = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backGroundColor,
      body: Column(
        children: [
          AppBarWidget(hintText: 'Hoá đơn của bạn'),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              decoration: const BoxDecoration(
                color: ColorPalette.backGroundColor,
              ),
              child: Obx(() {
                return controller.listBill.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: controller.listBill.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          BillModel bill = controller.listBill[index];
                          return GestureDetector(
                              onTap: () {
                                Get.to(() => DetailBillPage(), arguments: bill);
                              },
                              child: itemBill(bill));
                        },
                      )
                    : Container();
              }),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
      bottomSheet: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.only(bottom: 24, top: 16),
          width: MediaQuery.of(context).size.width,
          height: 6.h,
          child: Center(child: buttonAdd())),
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
                    ColorPalette.getStatus(bill.status),
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

  Widget buttonAdd() {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddBillPage());
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 53, right: 53, top: 10, bottom: 10),
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: ColorPalette.blackColor),
        child: Text(
          "+ Tạo thêm Bills",
          style: TextStyles.defaultStyle.medium.setTextSize(14).whiteTextColor,
        ),
      ),
    );
  }
}
