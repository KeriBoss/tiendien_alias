import 'dart:io';

import 'package:tiendien_alias/Sevice/local_auth_service.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/resgister/takeAvatar/takeAvatarPage.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'checkInfomationController.dart';

class CheckInformationPage extends StatelessWidget {
  var controller = Get.put(CheckInformationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff73B5E8),
          Color(0xffCDEEC7),
        ], transform: GradientRotation(167))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 61),
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
                      'Kiểm tra thông tin',
                      style: TextStyles.defaultStyle.medium.setTextSize(18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 120.h,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13),
                    )),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Kiểm tra lại thông tin cá nhân của bạn, vui lòng chụp lại nếu thông tin chưa khớp với CMT/CCCD',
                        style: TextStyles.defaultStyle,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      itemInfo('Họ và tên', controller.username.value),
                      itemInfo('Ngày sinh', controller.ngaySinh.value),
                      itemInfo('Số CMT/CCCD', controller.cccd.value),
                      itemInfo('Ngày cấp CMT/CCCD', controller.ngayCap.value),
                      Container(
                        width: 100.w,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ngày hết hạn',
                              style: TextStyles.defaultStyle
                                  .setTextSize(12)
                                  .setColor(const Color(0xffB8B8B8)),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.datetime,
                              controller: controller.ngayHetHan,
                              textAlignVertical: TextAlignVertical.top,
                              style: TextStyles.defaultStyle.setTextSize(12),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  isDense: true,
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                              validator: (value) => validatorText(value!),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 100.w,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nơi cấp CMT/CCCD',
                              style: TextStyles.defaultStyle
                                  .setTextSize(12)
                                  .setColor(const Color(0xffB8B8B8)),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            TextFormField(
                              controller: controller.noiCap,
                              maxLines: 2,
                              textInputAction: TextInputAction.done,
                              textAlignVertical: TextAlignVertical.top,
                              style: TextStyles.defaultStyle.setTextSize(12),
                              validator: (value) => validatorText(value!),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  isDense: true,
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            )
                          ],
                        ),
                      ),
                      itemInfo('Địa chỉ thường trú',
                          controller.diaChiThuongTru.value),
                      Container(
                        width: 100.w,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nơi ở hiện tại',
                              style: TextStyles.defaultStyle
                                  .setTextSize(12)
                                  .setColor(const Color(0xffB8B8B8)),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            TextFormField(
                              controller: controller.noiHienTai,
                              maxLines: 2,
                              textInputAction: TextInputAction.done,
                              textAlignVertical: TextAlignVertical.top,
                              style: TextStyles.defaultStyle.setTextSize(12),
                              validator: (value) => validatorText(value!),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  isDense: true,
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorPalette.blackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(37))),
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.file(
                                          File(controller.xFile!.path),
                                          width: 99,
                                          height: 68,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        Text(
                                          'Xác nhận thông tin',
                                          style: TextStyles.defaultStyle.medium
                                              .setTextSize(16),
                                        ),
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        Obx(() {
                                          return Text(
                                              'Hãy chắc chắn ${controller.cccd.value} là số CMT/CCCD của bạn',
                                              style: TextStyles.defaultStyle);
                                        }),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ColorPalette.blackColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(37),
                                                )),
                                            onPressed: () {
                                              //controller.updateInformationUser();
                                              Get.to(() => TakeAvatarPage());
                                            },
                                            child: Text(
                                              "Tiếp tục",
                                              style: TextStyles.defaultStyle
                                                  .whiteTextColor.medium,
                                            )),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ColorPalette.whiteColor,
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Colors.black),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(37),
                                                )),
                                            onPressed: () {
                                              controller.againInformation();
                                            },
                                            child: Text(
                                              "Sửa lại",
                                              style: TextStyles
                                                  .defaultStyle.medium,
                                            )),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            "Tiếp tục",
                            style:
                                TextStyles.defaultStyle.whiteTextColor.medium,
                          )),
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

  Widget itemInfo(String hintText, String value) {
    return Container(
      width: 100.w,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: TextStyles.defaultStyle
                .setTextSize(12)
                .setColor(const Color(0xffB8B8B8)),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            value,
            style: TextStyles.defaultStyle.setTextSize(12),
          ),
        ],
      ),
    );
  }

  Widget itemInfoInput(String hintText, String value) {
    return Container(
      width: 100.w,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: TextStyles.defaultStyle
                .setTextSize(12)
                .setColor(const Color(0xffB8B8B8)),
          ),
          const SizedBox(
            height: 4,
          ),
          TextFormField()
        ],
      ),
    );
  }
}
