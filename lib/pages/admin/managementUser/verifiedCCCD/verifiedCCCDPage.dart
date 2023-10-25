import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'verifiedCCCDController.dart';

class VerifiedCCCDPage extends StatelessWidget {
  final controller = Get.put(VerifiedCCCDController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backGroundColor,
      body: SingleChildScrollView(
        child: Column(
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
                          'Thông tin cá nhân',
                          style: TextStyles.defaultStyle.medium.setTextSize(18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: false,
                      initialValue: controller.userModel.phone,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(label: Text('Số điện thoại')),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: controller.userModel.name,
                      decoration:
                          const InputDecoration(label: Text('Họ Và Tên')),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                        enabled: false,
                        initialValue: controller.userModel.address,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          label: Text('Địa chỉ'),
                        ),
                        minLines: 1,
                        maxLines: null),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                        enabled: false,
                        initialValue: controller.userModel.cccd,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(label: Text('CCCD'))),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      height: 60.h,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mặt trước",
                                    style: TextStyles.defaultStyle.bold,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          color: Colors.grey.shade300,
                                          height: 25.h,
                                          width: 100.w,
                                          child: CachedNetworkImage(
                                            imageUrl: controller
                                                .userModel.urlCCCDBefore,
                                            fit: BoxFit.contain,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mặt sau",
                                    style: TextStyles.defaultStyle.bold,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        color: Colors.grey.shade300,
                                        height: 25.h,
                                        width: 100.w,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              controller.userModel.urlCCCDAfter,
                                          fit: BoxFit.contain,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                        enabled: false,
                        initialValue: controller.userModel.phone,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Số điện thoại'),
                        )),
                    SizedBox(
                      height: 3.h,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Giới tính",
                        style: TextStyles.defaultStyle.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Obx(
                          () => ListTile(
                            title: const Text("Nam"),
                            leading: Radio(
                                value: "Nam",
                                groupValue: controller.gender.value,
                                onChanged: (value) {
                                  //controller.gender.value = "Nam";
                                }),
                          ),
                        )),
                        Expanded(
                          child: Obx(
                            () => ListTile(
                              title: const Text("Nữ"),
                              leading: Radio(
                                  value: "Nữ",
                                  groupValue: controller.gender.value,
                                  onChanged: (value) {
                                    //controller.gender.value = "Nữ";
                                  }),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                        enabled: false,
                        initialValue: controller.userModel.yearOfBirth,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Năm sinh'),
                        )),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: controller.userModel.isBlock
                                      ? Colors.green
                                      : Colors.redAccent),
                              onPressed: () {
                                controller.userModel.isBlock == false
                                    ? controller.blockAccount()
                                    : controller.unBlockAccount();
                              },
                              child: Text(
                                controller.userModel.isBlock
                                    ? 'Mở khoá tài khoản'
                                    : 'Khóa tài khoản',
                                style: const TextStyle(
                                    color: ColorConstants.whiteColor),
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                controller.xacThuc();
                              },
                              child: const Text(
                                'Xác thực tài khoản',
                                style:
                                    TextStyle(color: ColorConstants.whiteColor),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
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
