import 'package:tiendien_alias/Sevice/localStorageService.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/khach_hang/setting/change_password/change_password_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'security_controller.dart';

class SecurityPage extends StatelessWidget {
  var controller = Get.put(SecurityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        AppBarWidget(hintText: 'Cài đặt và bảo mật'),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // InkWell(
              //   onTap: () {},
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              //     decoration: const BoxDecoration(
              //         color: ColorPalette.whiteColor,
              //         borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(8),
              //             topRight: Radius.circular(8))),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Ngôn ngữ",
              //           style: TextStyles.defaultStyle.medium,
              //         ),
              //         const Icon(
              //           Icons.arrow_forward_ios,
              //           size: 18,
              //           color: Color(0xffB1B1B1),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 2,
              // ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                decoration: const BoxDecoration(
                    color: ColorPalette.whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Face ID/Touch ID",
                      style: TextStyles.defaultStyle.medium,
                    ),
                    Obx(() => FlutterSwitch(
                          width: 35.0,
                          height: 20.0,
                          activeColor: const Color(0xff62C196),
                          padding: 2,
                          toggleSize: 14.0,
                          value: controller.isLight.value,
                          showOnOff: false,
                          onToggle: (val) {
                            controller.isLight.value = val;
                            LocalStorageService.setValue("face_id", val);
                          },
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ChangePasswordPage());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                  decoration: const BoxDecoration(
                    color: ColorPalette.whiteColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Đổi mật khẩu",
                        style: TextStyles.defaultStyle.medium,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xffB1B1B1),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              InkWell(
                onTap: () {
                  controller.deleteAccount();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                  decoration: const BoxDecoration(
                      color: ColorPalette.whiteColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Xóa tài khoản",
                        style: TextStyles.defaultStyle.medium,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xffB1B1B1),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
