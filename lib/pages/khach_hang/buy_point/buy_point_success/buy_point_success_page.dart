import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'buy_point_success_controller.dart';

class BuyPointSuccessPage extends StatelessWidget {
  var controller = Get.put(BuyPointSuccessController());
  final oCcy = NumberFormat("#,##0", 'en_US');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent going back
        return false;
      },
      child: Scaffold(
        body: SizedBox(
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 130,
              ),
              Image.asset(
                'assets/png/ic_success.png',
                width: 70,
                height: 70,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Giao dịch thành công!",
                style: TextStyles.defaultStyle.medium.setTextSize(18),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Chúc mừng bạn đã nạp thành công ",
                    style: TextStyles.defaultStyle,
                  ),
                  Text(
                    "${oCcy.format(controller.money)} point",
                    style: TextStyles.defaultStyle
                        .setColor(const Color(0xff62C196)),
                  ),
                ],
              ),
              Text(
                "vào tài khoản ${controller.currentUser.name}.",
                style: TextStyles.defaultStyle,
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: ButtonBlack(
                  hintText: 'Hoàn thành',
                  onPressed: () {
                    Get.offAllNamed('/bottomNavBarCustomer');
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Liên hệ nếu có khiếu nại / sự cố",
                style:
                    TextStyles.defaultStyle.setColor(const Color(0xffDD2222)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
