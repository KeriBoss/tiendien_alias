import 'dart:io';

import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'bank_transfer_controller.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BankTransferPage extends StatelessWidget {
  var controller = Get.put(BankTransferController());
  final oCcy = NumberFormat("#,##0", 'en_US');

  Future<bool> onWillPop() async {
    return (await Get.dialog(
          const AlertDialog(
            title: Text(
              'Thông báo',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            content: Text('Đang trong quá trình xử lý trong thể thoát'),
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorPalette.backGroundColor,
        body: Column(
          children: [
            AppBarWidget(
              hintText: 'Chuyển khoản ngân hàng',
            ),
            Container(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 18),
              decoration: const BoxDecoration(
                color: ColorPalette.backGroundColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cardBuyPoint(),
                    const SizedBox(
                      height: 16,
                    ),
                    infoBank(),
                    const SizedBox(
                      height: 16,
                    ),
                    uploadImage(),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          height: 5.h,
          margin:
              const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 24),
          child: ButtonBlack(
              hintText: 'Đã thanh toán',
              onPressed: () async {
                controller.startTimer();
                openDiaLog(context);
                await controller.handleBankTransfer();
              }),
        ),
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
              Text("Thời gian thực hiện: ",
                  style: TextStyles.defaultStyle.setTextSize(12)),
              Text(
                "00:59s",
                style: TextStyles.defaultStyle
                    .setTextSize(12)
                    .setColor(const Color(0xff62C196)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoBank() {
    Color colorGrey = const Color(0xffB1B1B1);
    return Obx(() {
      return controller.bankAdmin.value != null
          ? Container(
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
                        Obx(() {
                          return Text(
                            controller.bankAdmin.value!.nameBank,
                            style: TextStyles.defaultStyle,
                          );
                        })
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
                        Obx(() {
                          return Text(
                            controller.bankAdmin.value!.nameCustomer,
                            style: TextStyles.defaultStyle,
                          );
                        })
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
                        Obx(() {
                          return Text(
                            controller.bankAdmin.value!.stkBank,
                            style: TextStyles.defaultStyle,
                          );
                        })
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
                          "Chi nhánh",
                          style: TextStyles.defaultStyle.setColor(colorGrey),
                        ),
                        const Text(
                          'Ngân hàng Vietinbank ,\nchi nhánh sở giao dịch 1',
                          style: TextStyles.defaultStyle,
                          textAlign: TextAlign.end,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: const Color(0xffD9D9D9),
                  ),
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
                          'PHOENIX ${oCcy.format(controller.money)} point',
                          style: TextStyles.defaultStyle,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container();
    });
  }

  Widget uploadImage() {
    return GestureDetector(
      onTap: () {
        controller.pickerImage();
      },
      child: Obx(() {
        return controller.imagePath.value == ""
            ? Container(
                width: 100.w,
                padding: const EdgeInsets.only(top: 48, bottom: 15),
                decoration: BoxDecoration(
                  color: ColorPalette.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/png/ic_upload.png',
                      width: 44,
                      height: 44,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Up màn hình giao dịch\nđể rút gọn thời gian thanh toán",
                      style: TextStyles.defaultStyle
                          .setColor(const Color(0xffDD2222)),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            : Container(
                width: 100.w,
                height: 20.h,
                padding: const EdgeInsets.only(top: 48, bottom: 15),
                decoration: BoxDecoration(
                    color: ColorPalette.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: FileImage(File(controller.imagePath.value)),
                        fit: BoxFit.cover)),
              );
      }),
    );
  }

  void openDiaLog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 19, left: 20, right: 20),
              decoration: BoxDecoration(
                color: ColorPalette.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/png/ic_reload.png',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Giao dịch sẽ được hoàn",
                    style: TextStyles.defaultStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "tất trong: ",
                        style: TextStyles.defaultStyle,
                      ),
                      Obx(() {
                        return Text(
                          "00:${controller.seconds.value}",
                          style: TextStyles.defaultStyle
                              .setColor(const Color(0xff62C196)),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
