import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:tiendien_alias/pages/khach_hang/sell_point/detail_sell_point/detail_sell_point_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'sell_point_controller.dart';

class SellPointPage extends StatelessWidget {
  var controller = Get.put(SellPointController());
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ColorPalette.boxDecoration,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarWidget(hintText: 'Rút điểm'),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 16, top: 61, bottom: 20, right: 16),
              //   child: Row(
              //
              //     children: [
              //       InkWell(
              //           onTap: () {
              //             Get.close(1);
              //           },
              //           child: const Icon(Icons.arrow_back)),
              //       const SizedBox(width: 70,),
              //       Text('Rút điểm',
              //         style: TextStyles.defaultStyle.medium.setTextSize(18),
              //       ),
              //     ],
              //   ),
              // ),
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
                      titleText(hintText: 'Số tiền muốn nạp'),
                      inputPoint(),
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
                      titleText(hintText: 'Ngân hàng thụ hưởng'),
                      listBankCustomer()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listBankCustomer() {
    return Obx(() {
      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listBankCustomer.length,
        itemBuilder: (context, index) {
          BankCustomer bankCustomer = controller.listBankCustomer[index];
          return GestureDetector(
              onTap: () {
                if (controller.moneyController.text.trim() != "") {
                  num money = num.parse(controller.moneyController.text.trim());
                  if (controller.currentUser.money >= money) {
                    Get.to(() => DetailSellPointPage(), arguments: [
                      money,
                      controller.currentUser,
                      bankCustomer
                    ]);
                  } else {
                    Get.defaultDialog(
                        title: 'Thông báo',
                        content: const Text("Số điểm không hợp lệ"));
                  }
                } else {
                  Get.defaultDialog(
                      title: 'Thông báo',
                      content:
                          const Text("Vui lòng chọn hoặc nhập điểm để rút"));
                }
              },
              child: itemBank(bankCustomer.nameBank));
        },
      );
    });
  }

  Widget itemBank(String nameBank) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameBank,
            style: TextStyles.defaultStyle,
          ),
          Image.asset(
            'assets/png/ic_arrow.png',
            width: 24,
            height: 24,
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
              SizedBox(
                width: 100,
                height: 50,
                child: Center(
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    controller: controller.moneyController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      controller.selectedItemIndex.value = -1;
                    },
                  ),
                ),
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

  Widget titleText({required String hintText}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
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
