import 'dart:async';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/banner.dart';
import 'package:tiendien_alias/pages/khach_hang/account_link/acount_link_page.dart';
import 'package:tiendien_alias/pages/khach_hang/buy_point/buy_point_page.dart';
import 'package:tiendien_alias/pages/khach_hang/my_bill/list_my_bill/list_my_bill_page.dart';
import 'package:tiendien_alias/pages/khach_hang/sell_point/sell_point_page.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'home_customer_controller.dart';

class HomeCustomerPage extends StatelessWidget {
  var controller = Get.put(HomeCustomerController());
  final oCcy = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                width: 100.w,
                decoration: const BoxDecoration(
                    color: ColorPalette.blackColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoUser(),
                    const SizedBox(
                      height: 24,
                    ),
                    buildCardUser(),
                    const SizedBox(
                      height: 24,
                    ),
                    buildFuncMain(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),

              // show banner
              DateTime(2023, 9, 12).isAfter(DateTime.now())
                  ? Container(
                      width: 100.w,
                      height: 60.h,
                      margin: const EdgeInsets.only(
                          bottom: 16, top: 23, left: 24, right: 24),
                      decoration: BoxDecoration(
                        //color: const Color(0xffB1B1B1),
                        borderRadius: BorderRadius.circular(16),
                        // image: const DecorationImage(
                        //     image: AssetImage('assets/pngs/logo.png'),
                        //     fit: BoxFit.contain
                        // ),
                      ),
                    )
                  : Obx(() {
                      return ListView.builder(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 23),
                        itemCount: controller.listBanner.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          BannerModel banner = controller.listBanner[index];
                          return itemBanner(banner);
                        },
                      );
                    }),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemBanner(BannerModel banner) {
    return Container(
      width: 100.w,
      height: 15.h,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xffB1B1B1),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
            image: NetworkImage(banner.linkImage), fit: BoxFit.fill),
      ),
    );
  }

  Widget buildInfoUser() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return controller.currentUser.value != null &&
                  controller.currentUser.value!.urlAvatar != ""
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    controller.currentUser.value!.urlAvatar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/png/avatar.png',
                        width: 40,
                        height: 40,
                      );
                    },
                    width: 40,
                    height: 40,
                  ),
                )
              : Image.asset(
                  'assets/png/avatar.png',
                  width: 40,
                  height: 40,
                );
        }),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Xin chào',
              style: TextStyles.defaultStyle.setTextSize(12).whiteTextColor,
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(() {
              return controller.currentUser.value != null
                  ? Text(
                      controller.currentUser.value!.name,
                      style: TextStyles.defaultStyle.medium
                          .setTextSize(16)
                          .whiteTextColor,
                    )
                  : Container();
            }),
          ],
        )
      ],
    );
  }

  Widget buildCardUser() {
    return Container(
      width: 100.w,
      height: 12.h,
      decoration: BoxDecoration(
        color: const Color(0xffDFE9F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Image.asset(
            'assets/png/Ellipse 33.png',
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/png/Ellipse 34.png',
              )),
          Positioned(
            top: 15,
            right: 12,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 6, right: 10, top: 4, bottom: 4),
              decoration: BoxDecoration(
                color: ColorPalette.whiteColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/png/ic_money.png',
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Obx(() {
                    return controller.currentUser.value != null
                        ? Text(
                            oCcy.format(controller.currentUser.value!.money),
                            style: TextStyles.defaultStyle.setTextSize(12),
                          )
                        : Text(
                            "0",
                            style: TextStyles.defaultStyle.setTextSize(12),
                          );
                  })
                ],
              ),
            ),
          ),
          Positioned(
            top: 24,
            left: 24,
            child: Text(
              "Số dư ví ",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
          Positioned(
            top: 48,
            left: 24,
            child: Obx(() {
              return controller.currentUser.value != null
                  ? Text(
                      "${oCcy.format(controller.currentUser.value!.money)} VND",
                      style: TextStyles.defaultStyle.bold.setTextSize(24),
                    )
                  : Text(
                      "0 VND",
                      style: TextStyles.defaultStyle.bold.setTextSize(24),
                    );
            }),
          ),
        ],
      ),
    );
  }

  Widget cardIcon(
      {required Widget image,
      required String title,
      required Callback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image,
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyles.defaultStyle.whiteTextColor.setTextSize(12),
          )
        ],
      ),
    );
  }

  Widget buildFuncMain() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        cardIcon(
            image: Image.asset('assets/png/img_1.png'),
            title: 'Mua điểm',
            onPressed: () {
              if (controller.bankCustomer.value != null) {
                Get.to(() => BuyPointPage());
              } else {
                Get.bottomSheet(showBottomSheetLinkAccount());
              }
            }),
        const SizedBox(
          width: 47,
        ),
        cardIcon(
            image: Image.asset('assets/png/img_2.png'),
            title: 'Rút điểm',
            onPressed: () {
              if (controller.bankCustomer.value != null) {
                Get.to(() => SellPointPage(),
                    arguments: controller.currentUser.value);
              } else {
                Get.bottomSheet(showBottomSheetLinkAccount());
              }
            }),
        const SizedBox(
          width: 47,
        ),
        cardIcon(
            image: Stack(
              children: [
                Image.asset(
                  'assets/png/img_3.png',
                  width: 48,
                  height: 48,
                ),
                Positioned(
                    top: 12,
                    right: 11,
                    left: 13,
                    bottom: 12,
                    child: Image.asset(
                      'assets/png/img_4.png',
                      width: 24,
                      height: 24,
                    )),
              ],
            ),
            title: 'Đơn của tôi',
            onPressed: () {
              if (controller.bankCustomer.value != null) {
                Get.to(() => ListMyBillPage());
              } else {
                Get.bottomSheet(showBottomSheetLinkAccount());
              }
            }),
      ],
    );
  }

  Widget showBottomSheetLinkAccount() {
    return Container(
      decoration: const BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 37, bottom: 24),
            child: Image.asset(
              'assets/png/ic_share.png',
              width: 60,
              height: 60,
            ),
          ),
          Text(
            "Liên kết tài khoản",
            style: TextStyles.defaultStyle.medium.setTextSize(18),
          ),
          const SizedBox(
            height: 9,
          ),
          const Text(
            "Vui lòng liên kết tài khoản ngân hàng của bạn\nđể tiếp tục giao dịch ",
            style: TextStyles.defaultStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 37,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonBlack(
              hintText: 'Liên kết ngay',
              onPressed: () {
                Get.close(1);
                Get.to(() => AccountLinkPage());
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 100.w,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: ColorPalette.whiteColor,
                  border: Border.all(color: ColorPalette.blackColor)),
              child: Center(
                  child: Text(
                "Hủy",
                style: TextStyles.defaultStyle.medium,
              )),
            ),
          ),
          const SizedBox(
            height: 37,
          ),
        ],
      ),
    );
  }
}
