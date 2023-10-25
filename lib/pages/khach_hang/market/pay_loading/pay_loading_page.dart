import 'package:cached_network_image/cached_network_image.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/electricityBill.dart';
import 'package:tiendien_alias/pages/khach_hang/market/complete_payment/complete_payment_page.dart';
import 'package:tiendien_alias/pages/khach_hang/market/pay_loading/full_image_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:tiendien_alias/widgets/button_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'pay_loading_controller.dart';

class PayLoadingPage extends StatelessWidget {
  var controller = Get.put(PayLoadingController());
  final oCcy = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorPalette.backGroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: ColorPalette.boxDecoration,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 61, bottom: 20, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          controller.showReturnBill();
                        },
                        child: const Icon(Icons.arrow_back)),
                    Text(
                      'Tiến hành thanh toán',
                      style: TextStyles.defaultStyle.medium.setTextSize(18),
                    ),
                    const Text(" "),
                  ],
                ),
              ),
            ),
            timePayment(),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Text(
                "Tiến trình thanh toán",
                style: TextStyles.defaultStyle.medium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: headerTable(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.bill.value!.listBill.length,
                  itemBuilder: (context, index) {
                    ElectricityBillModel electricityBill =
                        controller.bill.value!.listBill[index];
                    return itemTable(electricityBill, index);
                  },
                );
              }),
            ),
            const SizedBox(
              height: 19,
            ),
            checkProgress(),
          ],
        ),
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          height: 51,
          margin:
              const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 24),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  List<ElectricityBillModel> list = controller
                      .bill.value!.listBill
                      .where((element) => element.isCheck == false)
                      .toList();
                  if (list.isNotEmpty) {
                    controller.showReturnBill();
                  } else {
                    Get.defaultDialog(
                        title: 'Thông báo',
                        content: Text(
                          "Bạn đã thanh toán tất cả bill\nnên không thể hoàn đơn",
                          textAlign: TextAlign.center,
                          style: TextStyles.defaultStyle.medium,
                        ));
                  }
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
                    "Hoàn đơn",
                    style: TextStyles.defaultStyle.medium,
                  )),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: ButtonBlack(
                      hintText: 'Hoàn thành',
                      onPressed: () {
                        // handle
                        controller.handleAllPayment();
                      })),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkProgress() {
    return GestureDetector(
      onTap: () {
        // handle check progress
        controller.reloadBill();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Kiểm tra tiến trình",
            style: TextStyles.defaultStyle.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Image.asset(
            'assets/png/ic_reload.png',
            width: 18,
            height: 18,
          ),
        ],
      ),
    );
  }

  Widget itemTable(ElectricityBillModel electricityBill, int index) {
    int stt = index + 1;
    num width = 100.w - 35;
    return Row(
      children: [
        Container(
          width: width * 0.12,
          height: 40,
          color: ColorPalette.whiteColor,
          child: Center(
            child: Text(
              stt.toString().padLeft(2, '0'),
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.39,
          height: 40,
          color: ColorPalette.whiteColor,
          padding: const EdgeInsets.only(left: 10, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                electricityBill.codeBill,
                style: TextStyles.defaultStyle.setTextSize(12),
              ),
              InkWell(
                  onTap: () async {
                    await Clipboard.setData(
                            ClipboardData(text: electricityBill.codeBill))
                        .then((_) {
                      final snackBar = SnackBar(
                        content: const Text("Copy thành công"),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
                    });
                  },
                  child: Image.asset('assets/png/ic_copy.png',
                      width: 18, height: 18))
            ],
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.21,
          height: 40,
          color: ColorPalette.whiteColor,
          child: Center(
            child: Text(
              oCcy.format(electricityBill.priceBill),
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.28,
          height: 40,
          color: ColorPalette.whiteColor,
          child: electricityBill.isCheck
              ? GestureDetector(
                  onTap: () {
                    Get.dialog(AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ButtonBlack(
                              hintText: 'Xem lại hình',
                              onPressed: () {
                                // close dialog
                                Get.close(1);
                                Get.dialog(
                                  FullScreenWidget(
                                    disposeLevel: DisposeLevel.Medium,
                                    child: Center(
                                      child: Hero(
                                        tag: "smallImage",
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                            electricityBill.urlImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          ButtonWhite(
                              hintText: 'Xóa hình',
                              onPressed: () {
                                // close dialog
                                Get.close(1);
                                controller
                                    .returnUpBill(electricityBill)
                                    .whenComplete(
                                        () => controller.reloadBill());
                              }),
                        ],
                      ),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check,
                        size: 18,
                        color: Color(0xff62C196),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Xong",
                        style: TextStyles.defaultStyle
                            .setTextSize(12)
                            .setColor(const Color(0xff62C196)),
                      ),
                    ],
                  ),
                )
              : InkWell(
                  onTap: () {
                    //handle up bill
                    if (controller.time.value != "00:00") {
                      controller.handleUpBill(electricityBill);
                    } else {
                      openError(Get.context!);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/png/ic_upload.png',
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Up bill",
                        style: TextStyles.defaultStyle
                            .setTextSize(12)
                            .setColor(const Color(0xffB1B1B1)),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  void openError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            decoration: BoxDecoration(
              color: ColorPalette.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/png/ic_sad.png',
                  width: 64,
                  height: 64,
                ),
                const SizedBox(
                  height: 11,
                ),
                Text(
                  "Đã hết thời gian thanh toán!",
                  style: TextStyles.defaultStyle.medium,
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Get.close(1);
                  },
                  child: Container(
                    width: 130,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: ColorPalette.blackColor,
                    ),
                    child: Center(
                        child: Text(
                      'Xong',
                      style: TextStyles.defaultStyle.medium.whiteTextColor,
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget headerTable() {
    num width = 100.w - 35;
    return Row(
      children: [
        Container(
          width: width * 0.12,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xffB1B1B1),
          ),
          child: Center(
            child: Text(
              "STT",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.39,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              Text(
                "Mã hoá đơn",
                style: TextStyles.defaultStyle.setTextSize(12),
              ),
              const SizedBox(
                width: 6,
              ),
              Image.asset(
                'assets/png/ic_copy_add.png',
                width: 16,
                height: 16,
              )
            ],
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.21,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "Số tiền",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.28,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "Trạng thái",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget timePayment() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorPalette.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/png/ic_clock.png',
            width: 28,
            height: 28,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            "Thời gian thanh toán: ",
            style: TextStyles.defaultStyle.setTextSize(12),
          ),
          Obx(() {
            return Text(
              controller.time.value,
              style: TextStyles.defaultStyle
                  .setColor(const Color(0xff62C196))
                  .setTextSize(12),
            );
          }),
        ],
      ),
    );
  }
}
