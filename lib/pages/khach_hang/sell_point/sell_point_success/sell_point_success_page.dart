import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'sell_point_success_controller.dart';

class SellPointSuccessPage extends StatelessWidget {
  var controller = Get.put(SellPointSuccessController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent going back
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100.w,
                decoration: ColorPalette.boxDecoration,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 61, bottom: 20, right: 16),
                  child: Column(
                    children: [
                      Text(
                        'Hoá đơn giao dịch',
                        style: TextStyles.defaultStyle.medium.setTextSize(18),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 28,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: cardSuccess(),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            child: Image.asset('assets/png/ic_success.png',
                                width: 52, height: 52)),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    buildPointCustomer(),
                    const SizedBox(
                      height: 28,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: ButtonBlack(
                          hintText: 'Hoàn thành',
                          onPressed: () {
                            Get.offAllNamed('/bottomNavBarCustomer');
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    contactCompany(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget contactCompany() {
    return Column(
      children: [
        Text(
          "Liên hệ nếu có khiếu nại / sự cố",
          style: TextStyles.defaultStyle.setColor(const Color(0xffDD2222)),
        ),
        const SizedBox(
          height: 28.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                controller.homeCustomerController.openZalo();
              },
              label: Text(
                'Phoenix zalo',
                style: TextStyles.defaultStyle.medium.setTextSize(16),
              ),
              icon: Image.asset(
                'assets/png/ic_zalo.png',
                width: 25,
                height: 25,
              ),
            ),
            const SizedBox(
              width: 48,
            ),
            TextButton.icon(
              onPressed: () {
                controller.homeCustomerController.openPhone();
              },
              label: Text(
                controller.homeCustomerController.phoneSupport,
                style: TextStyles.defaultStyle.medium.setTextSize(16),
              ),
              icon: Image.asset(
                'assets/png/ic_phone.png',
                width: 25,
                height: 25,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget cardSuccess() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 27),
      decoration: BoxDecoration(
        color: ColorPalette.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            "Chúc mừng! Bạn đã rút thành công ",
            style: TextStyles.defaultStyle.setTextSize(12),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                NumberFormat("#,##0", "en_US").format(controller.money),
                style: TextStyles.defaultStyle.semiBold.setTextSize(24),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "point",
                style: TextStyles.defaultStyle.setTextSize(16),
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
                "Điểm còn lại",
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
                    "${NumberFormat("#,##0", 'en_US').format(controller.currentUser.money)} point",
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
