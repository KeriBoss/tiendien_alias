import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/khach_hang/buy_point/bank_transfer/bank_transfer_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:tiendien_alias/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'confirm_transaction_controller.dart';

class ConfirmTransactionPage extends StatelessWidget {
  var controller = Get.put(ConfirmTransactionController());
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(hintText: 'Xác nhận giao dịch'),
          Container(
            height: 100.h - 120,
            padding: const EdgeInsets.only(left: 24, right: 24),
            decoration: const BoxDecoration(
              color: ColorPalette.backGroundColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText(hintText: "Thông tin nạp tiền"),
                  cardBuyPoint(),
                  titleText(hintText: "Nguồn tiền"),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => BankTransferPage(),
                          arguments: controller.money);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 16),
                      decoration: BoxDecoration(
                          color: ColorPalette.whiteColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Chuyển khoản ngân hàng",
                            style: TextStyles.defaultStyle,
                          ),
                          Image.asset(
                            'assets/png/ic_arrow.png',
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardBuyPoint() {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/png/ic_basket.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${oCcy.format(controller.money)} Point",
            style: TextStyles.defaultStyle.semiBold.setTextSize(18),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Nạp điểm vào tài khoản ",
                style: TextStyles.defaultStyle
                    .setTextSize(12)
                    .setColor(const Color(0xff9E9E9E)),
              ),
              Text(
                "Phoenix Pay",
                style: TextStyles.defaultStyle
                    .setTextSize(12)
                    .setColor(const Color(0xff62C196)),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Miễn phí dịch vụ",
            style: TextStyles.defaultStyle.setTextSize(12),
          ),
        ],
      ),
    );
  }

  Widget titleText({required String hintText}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Text(
        hintText,
        style: TextStyles.defaultStyle.medium,
      ),
    );
  }
}
