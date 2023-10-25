import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/khach_hang/buy_point/confirm_transaction/confirm_transaction_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:tiendien_alias/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'buy_point_controller.dart';

class BuyPointPage extends StatelessWidget {
  var controller = Get.put(BuyPointController());
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(hintText: 'Mua point'),
            // Container(
            //   decoration: ColorPalette.boxDecoration,
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //         left: 16, top: 61, bottom: 20, right: 16),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         InkWell(
            //             onTap: () {
            //               Get.close(1);
            //             },
            //             child: const Icon(Icons.arrow_back)),
            //
            //         Text('Mua point',
            //           style: TextStyles.defaultStyle.medium.setTextSize(18),
            //         ),
            //         const Icon(Icons.error_outline, size: 24,)
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              height: 100.h - 120,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 18),
              decoration: const BoxDecoration(
                color: ColorPalette.backGroundColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildPointCustomer(),
                    titleText(hintText: 'Số tiền muốn nạp'),
                    TextFormField(
                      controller: controller.moneyController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Nhập số tiền nạp',
                          suffixIcon: InkWell(
                              onTap: () {
                                controller.moneyController.clear();
                                controller.selectedItemIndex.value = -1;
                              },
                              child: const Icon(
                                Icons.clear,
                                color: ColorPalette.blackColor,
                                size: 18,
                              ))),
                    ),
                    titleText(hintText: 'Chọn nhanh'),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns
                        childAspectRatio: 11 / 5,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: controller.listMoney.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.selectedItemIndex.value = index;
                            controller.moneyController.text =
                                controller.listMoney[index].toString();
                          },
                          child: Obx(() {
                            return Container(
                              decoration: BoxDecoration(
                                  color: controller.selectedItemIndex.value ==
                                          index
                                      ? const Color(0xff64ADE5)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                  child: Text(
                                oCcy.format(controller.listMoney[index]),
                                style: controller.selectedItemIndex.value !=
                                        index
                                    ? TextStyles.defaultStyle
                                    : TextStyles.defaultStyle.whiteTextColor,
                              )),
                            );
                          }),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 38,
                    ),
                    ButtonBlack(
                      hintText: 'Tiếp tục',
                      onPressed: () {
                        num money =
                            num.parse(controller.moneyController.text.trim());
                        Get.to(() => ConfirmTransactionPage(),
                            arguments: money);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleText({required String hintText}) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 18),
      child: Text(
        hintText,
        style: TextStyles.defaultStyle.medium,
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
                  Obx(() {
                    return controller.currentUser.value != null
                        ? Text(
                            "${oCcy.format(controller.currentUser.value!.money)} point",
                            style: TextStyles.defaultStyle.setTextSize(13),
                          )
                        : Text(
                            "0 point",
                            style: TextStyles.defaultStyle.setTextSize(13),
                          );
                  })
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
