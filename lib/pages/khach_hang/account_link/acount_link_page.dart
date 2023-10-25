import 'package:cached_network_image/cached_network_image.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/khach_hang/account_link/info_bank_customer/info_bank_customer_page.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'acount_link_controller.dart';

class AccountLinkPage extends StatelessWidget {
  var controller = Get.put(AccountLinkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: ColorPalette.boxDecoration,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 61, bottom: 20),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Get.close(1);
                              },
                              child: const Icon(Icons.arrow_back)),
                          const SizedBox(
                            width: 70,
                          ),
                          Text(
                            'Liên kết tài khoản',
                            style:
                                TextStyles.defaultStyle.medium.setTextSize(18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100.h - 120,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              decoration: const BoxDecoration(
                color: ColorPalette.backGroundColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chọn nguồn tiền",
                      style: TextStyles.defaultStyle.medium,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.isOpen.value = !controller.isOpen.value;
                      },
                      child: Obx(() {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 17, horizontal: 16),
                          decoration: BoxDecoration(
                            color: ColorPalette.whiteColor,
                            borderRadius: controller.isOpen.value
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))
                                : BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Từ ngân hàng liên kết',
                                style: TextStyles.defaultStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Color(0xff62C196),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                    Obx(() {
                      return controller.isOpen.value
                          ? Container(
                              height: 370,
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                color: ColorPalette.whiteColor,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                              child: Obx(() {
                                return ListView.builder(
                                  itemCount: controller.listBank.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final bank = controller.listBank[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => InfoBankCustomerPage(),
                                            arguments: bank);
                                      },
                                      child: Container(
                                        color: ColorPalette.whiteColor,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image.network(
                                                  bank.logo,
                                                  width: 60,
                                                  height: 60,
                                                ),
                                                Text(
                                                  bank.shortName,
                                                  style:
                                                      TextStyles.defaultStyle,
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                                height: 1, color: Colors.grey)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                            )
                          : Container();
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
