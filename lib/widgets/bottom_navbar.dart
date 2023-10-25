import 'package:tiendien_alias/pages/customer/home_screen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';
import '../constants/color_palette.dart';
import '/constants/app_images.dart';
import '/constants/color_constants.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);

  final CustomerHomeController _homeScreenController =
      Get.put(CustomerHomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      padding: EdgeInsets.symmetric(
        horizontal: 4.5.w,
      ),
      decoration: const BoxDecoration(
        color: ColorConstants.whiteColor,
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _homeScreenController.isSelectedTask.value = false;
                _homeScreenController.isSelectedSupport.value = true;
                _homeScreenController.isSelectedChat.value = false;
                _homeScreenController.isSelectedHome.value = false;
                _homeScreenController.isSelectedDots.value = false;
                _homeScreenController.counter.value = 0;
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 1.8.h,
                  ),
                  SvgPicture.asset(
                    AppImages.iconSupport,
                    color: _homeScreenController.isSelectedSupport.value
                        ? ColorPalette.primaryColor
                        : ColorConstants.gray,
                    height: 3.5.h,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SvgPicture.asset(
                    AppImages.lineOrange,
                    width: 4.w,
                    height: 0.3.h,
                    color: _homeScreenController.isSelectedSupport.value
                        ? ColorPalette.primaryColor
                        : ColorConstants.whiteColor,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _homeScreenController.isSelectedTask.value = true;
                _homeScreenController.isSelectedChat.value = false;
                _homeScreenController.isSelectedSupport.value = false;
                _homeScreenController.isSelectedHome.value = false;
                _homeScreenController.isSelectedDots.value = false;
                _homeScreenController.counter.value = 1;
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 1.8.h,
                  ),
                  SvgPicture.asset(
                    AppImages.taskIcon,
                    color: _homeScreenController.isSelectedTask.value
                        ? ColorPalette.primaryColor
                        : ColorConstants.gray,
                    height: 3.5.h,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SvgPicture.asset(
                    AppImages.lineOrange,
                    width: 4.w,
                    height: 0.3.h,
                    color: _homeScreenController.isSelectedTask.value
                        ? ColorPalette.primaryColor
                        : ColorConstants.whiteColor,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _homeScreenController.isSelectedTask.value = false;
                _homeScreenController.isSelectedSupport.value = false;
                _homeScreenController.isSelectedChat.value = false;
                _homeScreenController.isSelectedHome.value = true;
                _homeScreenController.isSelectedDots.value = false;
                _homeScreenController.counter.value = 2;
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 1.8.h,
                  ),
                  SvgPicture.asset(
                    AppImages.homeIcon,
                    color: _homeScreenController.isSelectedHome.value
                        ? ColorPalette.primaryColor
                        : ColorConstants.gray,
                    height: 3.5.h,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SvgPicture.asset(
                    AppImages.lineOrange,
                    width: 4.w,
                    height: 0.3.h,
                    color: _homeScreenController.isSelectedHome.value
                        ? ColorPalette.primaryColor
                        : ColorConstants.whiteColor,
                  ),
                ],
              ),
            ),
            //Container(),
            GestureDetector(
              onTap: () {
                _homeScreenController.isSelectedTask.value = false;
                _homeScreenController.isSelectedChat.value = true;
                _homeScreenController.isSelectedSupport.value = false;
                _homeScreenController.isSelectedHome.value = false;
                _homeScreenController.isSelectedDots.value = false;
                _homeScreenController.counter.value = 3;
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 1.8.h,
                  ),
                  SvgPicture.asset(
                    AppImages.iconFollow,
                    color: _homeScreenController.isSelectedChat.value
                        ? ColorPalette.primaryColor
                        : ColorConstants.gray,
                    height: 3.5.h,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SvgPicture.asset(
                    AppImages.lineOrange,
                    width: 4.w,
                    height: 0.3.h,
                    color: _homeScreenController.isSelectedChat.value
                        ? ColorPalette.primaryColor
                        : ColorConstants.whiteColor,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _homeScreenController.isSelectedSupport.value = false;
                _homeScreenController.isSelectedTask.value = false;
                _homeScreenController.isSelectedChat.value = false;
                _homeScreenController.isSelectedHome.value = false;
                _homeScreenController.isSelectedDots.value = true;
                _homeScreenController.counter.value = 4;
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 1.8.h,
                  ),
                  SvgPicture.asset(
                    "assets/svgs/ic_profile.svg",
                    color: _homeScreenController.isSelectedDots.value
                        ? ColorPalette.primaryColor
                        : ColorConstants.gray,
                    height: 3.5.h,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SvgPicture.asset(
                    AppImages.lineOrange,
                    width: 4.w,
                    height: 0.3.h,
                    color: _homeScreenController.isSelectedDots.value
                        ? ColorPalette.primaryColor
                        : ColorConstants.whiteColor,
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
