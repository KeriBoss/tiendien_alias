import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'link_success_controller.dart';

class LinkSuccessPage extends StatelessWidget {
  var controller = Get.put(LinkSuccessController());

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
              SizedBox(
                height: 16.h,
              ),
              Image.asset(
                'assets/png/link_success.png',
                width: 70,
                height: 70,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Liên kết thành công",
                style: TextStyles.defaultStyle.medium.setTextSize(18),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Chúc mừng bạn liên kết thành công\nvới tài khoản ${controller.bankCustomer.nameCustomer}.",
                style: TextStyles.defaultStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: ButtonBlack(
                  hintText: 'Về Trang Chủ',
                  onPressed: () {
                    Get.offAllNamed('/bottomNavBarCustomer');
                  },
                ),
              ),
              SizedBox(
                height: 29.h,
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
