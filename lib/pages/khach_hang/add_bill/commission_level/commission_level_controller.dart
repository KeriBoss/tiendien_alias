import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/pages/khach_hang/add_bill/order_sell/order_sell_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommissionLevelController extends GetxController {
  var percent1 = TextEditingController();
  var percent2 = TextEditingController();
  var percent3 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<BillModel> listBill = Get.arguments;

  savePercent() {
    String percent =
        '${percent1.text == '' ? '0' : percent1.text}.${percent2.text == '' ? '0' : percent2.text}${percent3.text == '' ? '0' : percent3.text}';
    num numPercent = num.parse(percent);
    for (var item in listBill) {
      item.discountBill = numPercent;
    }
    print(numPercent);

    if (numPercent <= 2) {
      percent1.clear();
      percent2.clear();
      percent3.clear();
      Get.to(() => OrderSellPage(), arguments: listBill);
    } else {
      openDiaLog(Get.context!);
    }
  }

  void openDiaLog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding:
                const EdgeInsets.only(top: 16, bottom: 19, left: 20, right: 20),
            decoration: BoxDecoration(
              color: ColorPalette.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/png/ic_sad.png',
                  width: 32,
                  height: 32,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Mức hoa hồng không hợp lệ",
                  style: TextStyles.defaultStyle
                      .setTextSize(18)
                      .setColor(ColorPalette.errorColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Mức hoa hồng tối đa: 2%\nVui lòng nhập lại",
                  textAlign: TextAlign.center,
                  style: TextStyles.defaultStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
