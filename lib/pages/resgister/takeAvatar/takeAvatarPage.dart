import 'dart:io';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/resgister/createdAccount/createdAccountPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'takeAvatarController.dart';

class TakeAvatarPage extends StatelessWidget {
  var controller = Get.put(TakeAvatarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
  }

  Container body() {
    return Container(
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
                    'Chụp hình khuôn mặt',
                    style: TextStyles.defaultStyle.medium.setTextSize(18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 100.h,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                  )),
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 24),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: () {
                              controller.takeImage();
                            },
                            child: const Icon(
                              Icons.camera_alt,
                              size: 30,
                            ))),
                  ),
                  Center(
                    child: Obx(() {
                      return controller.imageFile.value != null
                          ? Image.file(
                              controller.imageFile.value!,
                              width: 290,
                              fit: BoxFit.contain,
                            )
                          : Container(
                              height: 290,
                            );
                    }),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPalette.blackColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(37)),
                        ),
                        onPressed: () {
                          if (controller.imageFile.value != null) {
                            Get.to(() => CreatedAccountPage());
                          } else {
                            Get.defaultDialog(
                                title: 'Thông báo',
                                content: const Text("Vui lòng chụp khuôn mặt"));
                          }
                        },
                        child: Text(
                          "Tiếp tục",
                          style: TextStyles.defaultStyle.whiteTextColor.medium,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
