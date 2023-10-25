import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'complete_payment_controller.dart';

class CompletePaymentPage extends StatelessWidget {
  var controller = Get.put(CompletePayemntController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent going back
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 18.h,
            ),
            Image.asset(
              'assets/png/ic_success.png',
              width: 70,
              height: 70,
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              "Giao dịch thành công!",
              style: TextStyles.defaultStyle.setTextSize(18).medium,
            ),
            const SizedBox(height: 12),
            Text(
              "Bạn đã thanh toán thành công toàn bộ list bill",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: ButtonBlack(
                hintText: 'Quay về trang chủ',
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
            )
          ],
        ),
      ),
    );
  }
}
