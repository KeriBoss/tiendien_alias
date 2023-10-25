import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../../../validator/validatorString.dart';
import 'logic.dart';

class QuanLyHoaHongPage extends StatelessWidget {
  final logic = Get.put(QuanLyHoaHongLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: ColorPalette.boxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 61, bottom: 20, right: 16),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.close(1);
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          child: const Icon(Icons.arrow_back)),
                      const SizedBox(
                        width: 70,
                      ),
                      Text(
                        'Quản lý hoa hồng',
                        style: TextStyles.defaultStyle.medium.setTextSize(18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: logic.key,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/pngs/booking.png',
                      height: Get.height / 3,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: Text(
                    //     'Số tiền hoa hồng sau khi giới thiệu thành công cho người giới thiệu và người nhập mã giới thiệu',
                    //     style: TextStyles.defaultStyle.setTextSize(17),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Số tiền người mời",
                        style: TextStyles.defaultStyle.medium,
                      ),
                    ),
                    Obx(() {
                      return logic.hoaHongNguoiMoi.value != null
                          ? TextFormField(
                              controller: logic.soTienNguoiMoi,
                              decoration: const InputDecoration(
                                suffix: Text(
                                  "VNĐ",
                                  style: TextStyles.defaultStyle,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (v) => validateNumber(v!),
                            )
                          : TextFormField(
                              controller: logic.soTienNguoiMoi,
                              decoration: const InputDecoration(
                                suffix: Text(
                                  "VNĐ",
                                  style: TextStyles.defaultStyle,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (v) => validateNumber(v!),
                            );
                    }),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Số tiền người nhận",
                        style: TextStyles.defaultStyle.medium,
                      ),
                    ),
                    Obx(() {
                      return logic.hoaHongNguoiNhan.value != null
                          ? TextFormField(
                              controller: logic.soTienNguoiNhan,
                              decoration: const InputDecoration(
                                  suffix: Text(
                                "VNĐ",
                                style: TextStyles.defaultStyle,
                              )),
                              keyboardType: TextInputType.number,
                              validator: (v) => validateNumber(v!),
                            )
                          : TextFormField(
                              controller: logic.soTienNguoiNhan,
                              decoration: const InputDecoration(
                                  suffix: Text(
                                "VNĐ",
                                style: TextStyles.defaultStyle,
                              )),
                              keyboardType: TextInputType.number,
                              validator: (v) => validateNumber(v!),
                            );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonBlack(
                        hintText: 'Lưu',
                        onPressed: () {
                          if (logic.key.currentState!.validate()) {
                            logic.addHoaHong();
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
