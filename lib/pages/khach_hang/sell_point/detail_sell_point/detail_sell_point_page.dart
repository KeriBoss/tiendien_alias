import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/khach_hang/sell_point/sell_point_success/sell_point_success_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'detail_sell_point_controller.dart';

class DetailSellPointPage extends StatelessWidget {
  var controller = Get.put(DetailSellPointController());
  final oCcy = NumberFormat("#,##0", 'en_US');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: ColorPalette.boxDecoration,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWidget(hintText: 'Rút điểm'),
                Container(
                  height: 100.h,
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 18),
                  decoration: const BoxDecoration(
                    color: ColorPalette.backGroundColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildPointCustomer(),
                        const SizedBox(
                          height: 16,
                        ),
                        inputPoint(),
                        const SizedBox(
                          height: 16,
                        ),
                        infoBank(),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          height: 5.h,
          margin:
              const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 24),
          child: ButtonBlack(
              hintText: 'Xác nhận',
              onPressed: () {
                controller.startTimer();
                if (controller.isFaceId) {
                  controller.checkFaceID();
                } else {
                  controller.openDiaLog(Get.context!);
                  controller.sellPoint();
                }
              }),
        ),
      ),
    );
  }

  Widget infoBank() {
    Color colorGrey = const Color(0xffB1B1B1);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ngân hàng thụ hưởng",
                  style: TextStyles.defaultStyle.setColor(colorGrey),
                ),
                Text(
                  controller.bankCustomer.nameBank,
                  style: TextStyles.defaultStyle,
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Họ và tên",
                  style: TextStyles.defaultStyle.setColor(colorGrey),
                ),
                Text(
                  controller.bankCustomer.nameCustomer,
                  style: TextStyles.defaultStyle,
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Số tài khoản",
                  style: TextStyles.defaultStyle.setColor(colorGrey),
                ),
                Text(
                  controller.bankCustomer.stkBank,
                  style: TextStyles.defaultStyle,
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 12),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text("Chi nhánh", style: TextStyles.defaultStyle.setColor(colorGrey),),
          //       const Text('Ngân hàng Vietinbank ,\nchi nhánh sở giao dịch 1', style: TextStyles.defaultStyle,
          //         textAlign: TextAlign.end,
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 1,
          //   color: const Color(0xffD9D9D9),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nội dung CK",
                  style: TextStyles.defaultStyle.setColor(colorGrey),
                ),
                Text(
                  'Rút ${oCcy.format(controller.money)} point',
                  style: TextStyles.defaultStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget inputPoint() {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.only(top: 24, bottom: 26),
      decoration: BoxDecoration(
        color: ColorPalette.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            "Nhập số điểm muốn rút",
            style: TextStyles.defaultStyle
                .setTextSize(12)
                .setColor(const Color(0xff959595)),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                oCcy.format(controller.money),
                style: TextStyles.defaultStyle.semiBold.setTextSize(24),
              ),
              const SizedBox(
                width: 3,
              ),
              Container(
                width: 2,
                height: 27,
                color: ColorPalette.blackColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "point",
                style: TextStyles.defaultStyle.medium.setTextSize(16),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildPointCustomer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Image.asset(
            'assets/pngs/logo.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Điểm hiện có",
                style: TextStyles.defaultStyle.setTextSize(13),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/png/ic_money.png',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${oCcy.format(controller.currentUser.money)} point",
                    style: TextStyles.defaultStyle.setTextSize(13),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
