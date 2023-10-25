import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../constants/app_images.dart';

class ScreenTop extends StatelessWidget {
  final String boardingTitle;

  ScreenTop(this.boardingTitle);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 23.7.h,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              AppImages.orangePolygon,
              height: 21.h,
            ),
          ),
          boardingTitle == 'back'
              ? Positioned(
                  top: 7.h,
                  left: 5.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(
                          AppImages.backArrow,
                        ),
                        onTap: () => Get.back(),
                      ),
                    ],
                  ),
                )
              : Positioned(
                  top: 3.5.h,
                  left: 7.w,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
