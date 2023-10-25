import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:tiendien_alias/pages/khach_hang/account_link/acount_link_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'payment_methods_controller.dart';

class PaymentMethodsPage extends StatelessWidget {
  var controller = Get.put(PaymentMethodsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(hintText: 'Phương thức thanh toán'),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Obx(() {
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.listBankCustomer.length,
                itemBuilder: (context, index) {
                  BankCustomer bankCustomer =
                      controller.listBankCustomer[index];
                  int stt = 0;
                  if (controller.listBankCustomer.length == 1) {
                    stt = 0;
                  }
                  if (controller.listBankCustomer.length == 2) {
                    int last = controller.listBankCustomer.length - 1;
                    if (index == 0) {
                      stt = 1;
                    }
                    if (last == index) {
                      stt = 3;
                    }
                  }
                  if (controller.listBankCustomer.length > 2) {
                    int last = controller.listBankCustomer.length - 1;
                    if (index == 0) {
                      stt = 1;
                    } else if (last == index) {
                      stt = 3;
                    } else {
                      stt = 2;
                    }
                  }
                  return itemBank(bankCustomer, stt);
                },
              );
            }),
          ),
        ],
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 6.h,
        margin: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 25),
        child: ButtonBlack(
            hintText: 'Thêm ngân hàng liên kết +',
            onPressed: () {
              Get.to(() => AccountLinkPage());
            }),
      ),
    );
  }

  Widget itemBank(BankCustomer bankCustomer, int index) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: ColorPalette.whiteColor,
        borderRadius: getBorderRadius(index),
      ),
      child: Row(
        children: [
          bankCustomer.logoBank != ''
              ? Image.network(
                  bankCustomer.logoBank,
                  width: 40,
                  height: 40,
                  fit: BoxFit.fitWidth,
                )
              : const SizedBox(
                  width: 40,
                  height: 40,
                ),
          const SizedBox(
            width: 16,
          ),
          Text(
            bankCustomer.nameBank,
            style: TextStyles.defaultStyle.medium,
          ),
          const Expanded(
              child: Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xffB1B1B1),
              size: 18,
            ),
          ))
        ],
      ),
    );
  }

  BorderRadius getBorderRadius(int index) {
    if (index == 1) {
      return const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      );
    }
    if (index == 2) {
      return BorderRadius.circular(0);
    }
    if (index == 3) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }
    return BorderRadius.circular(8);
  }
}
