import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/scan_qr/cameraBeforePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'verifiedCCCDController.dart';

class VerifiedCCCDPage extends StatelessWidget {
  var controller = Get.put(VerifiedCCCDController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xff73B5E8),
            Color(0xffCDEEC7),
          ],
          transform: GradientRotation(167),
        )),
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
                      'Xác thực CMT/CCCD',
                      style: TextStyles.defaultStyle.medium.setTextSize(18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 100.w,
                height: 100.h,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13),
                    )),
                child: Form(
                  //key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Chụp ảnh CMT/CCCD",
                          style: TextStyles.defaultStyle.medium.setTextSize(16),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Chụp ảnh CMT/CCCD của bạn để xác thực, lưu ý những điều sau đây",
                          style: TextStyles.defaultStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Container(
                              width: 99,
                              height: 63,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: const Color(0xffD9D9D9),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/pngs/cccd1.png'))),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            const Expanded(
                              child: Text(
                                'Giấy tờ chính chủ, còn hiệu lực, không phải bản photo,copy',
                                style: TextStyles.defaultStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Container(
                              width: 99,
                              height: 63,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: const Color(0xffD9D9D9),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/pngs/cccd2.png'))),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            const Expanded(
                              child: Text(
                                'Không chụp ảnh giấy tờ bị mất góc, hãy giữ thẳng trong khung',
                                style: TextStyles.defaultStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Container(
                              width: 99,
                              height: 63,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: const Color(0xffD9D9D9),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/pngs/cccd3.png'))),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            const Expanded(
                              child: Text(
                                'Không chụp ảnh mờ, lóe sáng',
                                style: TextStyles.defaultStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                      ),
                      Obx(() {
                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            "Xác nhận bạn sẽ chịu hoàn toàn trách nhiệm với những giấy tờ mình cung cấp",
                            style: TextStyles.defaultStyle,
                          ),
                          value: controller.isCheck.value,
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          checkColor: Colors.white,
                          activeColor: const Color(0xff91CD91),
                          onChanged: (value) {
                            controller.isCheck.value =
                                !controller.isCheck.value;
                          },
                        );
                      }),
                      const SizedBox(
                        height: 185,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorPalette.blackColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(37))),
                            onPressed: () {
                              if (controller.isCheck.value) {
                                Get.to(() => const CameraBeforePage());
                              } else {
                                Get.snackbar(
                                  'Thông báo',
                                  'Vui lòng Xác nhận bạn sẽ chịu hoàn toàn trách nhiệm với những giấy tờ mình cung cấp',
                                  colorText: Colors.white,
                                  backgroundColor: Colors.redAccent,
                                );
                              }
                            },
                            child: Text(
                              "Bắt đầu chụp ảnh",
                              style:
                                  TextStyles.defaultStyle.whiteTextColor.medium,
                            )),
                      ),
                      const SizedBox(
                        height: 42,
                      ),
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
}
