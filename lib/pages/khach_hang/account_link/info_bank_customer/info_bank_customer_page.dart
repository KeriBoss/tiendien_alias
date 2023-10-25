import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/khach_hang/account_link/link_success/link_success_page.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:tiendien_alias/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'info_bank_customer_controller.dart';

class InfoBankCustomerPage extends StatelessWidget {
  var controller = Get.put(InfoBankCustomerController());

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
                            'Thông tin tài khoản',
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
              decoration: const BoxDecoration(
                color: ColorPalette.backGroundColor,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleWidget(hintText: 'Tên ngân hàng'),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          controller: controller.nameBank,
                          style: TextStyles.defaultStyle.medium,
                          readOnly: true,
                          enabled: false,
                        ),
                      ),
                      const TitleWidget(hintText: 'Số tài khoản'),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          controller: controller.stkBank,
                          style: TextStyles.defaultStyle.medium,
                          decoration: const InputDecoration(
                              hintText: 'Nhập số tài khoản'),
                          validator: (value) => validatorText(value!),
                        ),
                      ),
                      const TitleWidget(hintText: 'Chủ tài khoản'),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          style: TextStyles.defaultStyle.medium,
                          controller: controller.nameUser,
                          decoration: const InputDecoration(
                              hintText: 'Nhập chủ tài khoản'),
                          validator: (value) => validatorText(value!),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Obx(() {
                        return CheckboxListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 24),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Xác nhận bạn đã ',
                                  style:
                                      TextStyles.defaultStyle.setTextSize(12)),
                              TextSpan(
                                  text: 'đủ 18 tuổi',
                                  style: TextStyles.defaultStyle
                                      .setTextSize(12)
                                      .setColor(const Color(0xff22587A))),
                              TextSpan(
                                  text: ', là ',
                                  style:
                                      TextStyles.defaultStyle.setTextSize(12)),
                              TextSpan(
                                  text: 'công dân Việt Nam ',
                                  style: TextStyles.defaultStyle
                                      .setTextSize(12)
                                      .setColor(const Color(0xff22587A))),
                              TextSpan(
                                  text:
                                      'và là người cư trú, không có dấu hiệu là ',
                                  style:
                                      TextStyles.defaultStyle.setTextSize(12)),
                              TextSpan(
                                  text: 'người ngoài hành tinh ',
                                  style: TextStyles.defaultStyle
                                      .setTextSize(12)
                                      .setColor(const Color(0xff22587A))),
                              TextSpan(
                                  text: 'và tuân thủ ',
                                  style:
                                      TextStyles.defaultStyle.setTextSize(12)),
                              TextSpan(
                                  text: 'Điều kiện & Điều khoản sử dụng ',
                                  style: TextStyles.defaultStyle
                                      .setTextSize(12)
                                      .setColor(const Color(0xff62C196))),
                              TextSpan(
                                  text: 'của chúng tôi.',
                                  style:
                                      TextStyles.defaultStyle.setTextSize(12)),
                            ]),
                          ),
                          value: controller.isCheck.value,
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            // side:const BorderSide(
                            //   color: Color(0xff91CD91),
                            //   width: 1
                            // )
                          ),
                          checkColor: Colors.white,
                          activeColor: const Color(0xff91CD91),
                          onChanged: (value) {
                            controller.isCheck.value =
                                !controller.isCheck.value;
                          },
                        );
                      }),
                      SizedBox(
                        height: 14.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ButtonBlack(
                          hintText: 'Tiến hành xác minh',
                          onPressed: () {
                            if (controller.isCheck.value) {
                              if (controller.isFaceId) {
                                controller.checkFaceID();
                              } else {
                                controller.linkBankForCustomer();
                              }
                            } else {
                              Get.defaultDialog(
                                  title: 'Thông báo',
                                  content: const Text(
                                    "Vui lòng tích vào\nĐiều kiện & Điều khoản sử dụng",
                                    textAlign: TextAlign.center,
                                  ));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
