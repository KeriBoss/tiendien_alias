import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/pages/khach_hang/add_bill/commission_level/commission_level_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'choose_fee_controller.dart';

class ChooseFeePage extends StatelessWidget {
  var controller = Get.put(ChooseFeeController());
  final oCcy = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(hintText: 'Chọn phí'),
          // Container(
          //   decoration: ColorPalette.boxDecoration,
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //         left: 16, top: 61, bottom: 20, right: 16),
          //     child: Row(
          //       children: [
          //         InkWell(
          //             onTap: () {
          //               Get.close(1);
          //               FocusManager.instance.primaryFocus!.unfocus();
          //             },
          //             child: const Icon(Icons.arrow_back)),
          //         const SizedBox(width: 70,),
          //         Text('Chọn phí',
          //           style: TextStyles.defaultStyle.medium.setTextSize(18),
          //         ),
          //
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Obx(() {
              return Text(
                "Danh sách hóa đơn (${controller.quantityBill.value}/50)",
                style: TextStyles.defaultStyle.medium,
              );
            }),
          ),

          Column(
            children: controller.listBill.map((e) => itemBill(e)).toList(),
          ),
        ],
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 6.h,
        //padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    hintText: 'Chọn Mức Hoa Hồng',
                    onPressed: () {
                      Get.to(() => CommissionLevelPage(),
                          arguments: controller.listBill);
                    })),
          ],
        ),
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
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 5, left: 24, right: 24),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Đơn: ${formatCodeBill(bill.id)}",
            style: TextStyles.defaultStyle.medium,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Số lượng: ${bill.listBill.length} hóa đơn",
            style: TextStyles.defaultStyle.setTextSize(12),
          ),
          const SizedBox(
            height: 4,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Giá: ', style: TextStyles.defaultStyle.setTextSize(12)),
            TextSpan(
                text: '${oCcy.format(bill.totalBill)} VND',
                style: TextStyles.defaultStyle
                    .setTextSize(12)
                    .setColor(const Color(0xff62C196))),
          ]))
        ],
      ),
    );
  }
}
