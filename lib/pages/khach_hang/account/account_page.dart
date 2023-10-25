import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:tiendien_alias/widgets/button_white.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'account_controller.dart';

class AccountPage extends StatelessWidget {
  var controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backGroundColor,
      body: Column(
        children: [
          AppBarWidget(
            hintText: 'Hồ sơ của tôi',
          ),
          SizedBox(
            height: 4.h,
          ),
          Stack(
            children: [
              controller.homeCustomerController.currentUser.value!.urlAvatar ==
                      ""
                  ? CircleAvatar(
                      backgroundColor: ColorPalette.backGroundColor,
                      backgroundImage: const AssetImage(
                        'assets/png/avatar_circle.png',
                      ),
                      maxRadius: 19.w,
                    )
                  : CircleAvatar(
                      backgroundColor: ColorPalette.backGroundColor,
                      backgroundImage: NetworkImage(
                        controller.homeCustomerController.currentUser.value!
                            .urlAvatar,
                      ),
                      maxRadius: 19.w,
                    ),
              Positioned(
                bottom: 1,
                right: 5.w,
                child: InkWell(
                    onTap: () {
                      Get.bottomSheet(showBottomSheetChooseAvatar());
                    },
                    child: Image.asset(
                      'assets/png/ic_edit_black.png',
                      width: 24,
                      height: 24,
                    )),
              )
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          infoUser(),
        ],
      ),
    );
  }

  Widget infoUser() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
                color: ColorPalette.whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Họ và tên",
                  style: TextStyles.defaultStyle
                      .setColor(const Color(0xffB8B8B8))
                      .setTextSize(12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  controller.currentUser.value!.name,
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: ColorPalette.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Số điện thoại",
                  style: TextStyles.defaultStyle
                      .setColor(const Color(0xffB8B8B8))
                      .setTextSize(12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  controller.currentUser.value!.phone,
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: ColorPalette.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Giới tính",
                  style: TextStyles.defaultStyle
                      .setColor(const Color(0xffB8B8B8))
                      .setTextSize(12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  controller.currentUser.value!.gender,
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: ColorPalette.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quốc tịch",
                  style: TextStyles.defaultStyle
                      .setColor(const Color(0xffB8B8B8))
                      .setTextSize(12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Việt Nam',
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
                color: ColorPalette.whiteColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Số CMT/CCCD",
                  style: TextStyles.defaultStyle
                      .setColor(const Color(0xffB8B8B8))
                      .setTextSize(12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  controller.currentUser.value!.cccd,
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showBottomSheetChooseAvatar() {
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
          const SizedBox(
            height: 25,
          ),
          Text(
            "Thay đổi ảnh đại diện",
            style: TextStyles.defaultStyle.medium.setTextSize(18),
          ),
          const SizedBox(
            height: 26,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonBlack(
              hintText: 'Chụp ảnh',
              onPressed: () {
                Get.close(1);
                controller.pickerImageCamera();
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonWhite(
              hintText: 'Chọn từ thư viện',
              onPressed: () {
                Get.close(1);
                controller.pickerImageSource();
              },
            ),
          ),
          const SizedBox(
            height: 29,
          ),
        ],
      ),
    );
  }
}
