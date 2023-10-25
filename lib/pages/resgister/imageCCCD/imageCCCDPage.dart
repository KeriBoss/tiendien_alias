import 'dart:io';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/resgister/checkInfomation/checkInfomationPage.dart';
import 'package:tiendien_alias/pages/scan_qr/cameraBeforePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'imageCCCDController.dart';

class ImageCCCDPage extends StatelessWidget {
  var controller = Get.put(ImageCCCDController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 24, bottom: 42),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.off(() => const CameraBeforePage());
                },
                child: Container(
                  width: 98,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(68),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Center(
                      child: Text(
                    "Chụp lại",
                    style: TextStyles.defaultStyle.medium,
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => CheckInformationPage(),
                      arguments: controller.data);
                },
                child: Container(
                  width: 221,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(68),
                      color: Colors.black),
                  child: Center(
                      child: Text(
                    "Sử dụng ảnh",
                    style: TextStyles.defaultStyle.medium.whiteTextColor,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xff73B5E8),
            Color(0xffCDEEC7),
          ],
          transform: GradientRotation(167),
        )),
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
                    'Xác thực CMT/CCCD',
                    style: TextStyles.defaultStyle.medium.setTextSize(18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: 100.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Center(
                      child: Obx(() {
                        return Image.file(
                          File(controller
                              .cameraSelfController.fileCCCDBefore.value!.path),
                          width: 288,
                          height: 172,
                          fit: BoxFit.cover,
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Center(
                      child: Obx(() {
                        return Image.file(
                          File(controller
                              .cameraSelfController.fileCCCDAfter.value!.path),
                          width: 288,
                          height: 172,
                          fit: BoxFit.cover,
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Center(
                      child: Text(
                        "Xem lại ảnh chụp",
                        style: TextStyles.defaultStyle.medium.setTextSize(16),
                      ),
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
}
