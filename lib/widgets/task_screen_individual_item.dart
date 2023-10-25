import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '/constants/app_images.dart';
import '/constants/color_constants.dart';
import '/constants/font_constants.dart';

class TaskScreenIndividualItem extends StatelessWidget {
  final String title;
  final String status;
  final Color? color;
  final int offers;
  final int comments;
  final int price;

  const TaskScreenIndividualItem({
    Key? key,
    required this.title,
    required this.status,
    required this.offers,
    required this.comments,
    required this.price,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: 1.w,
        right: 1.w,
        bottom: 3.5.w,
      ),
      elevation: 2,
      child: Container(
        width: 97.w,
        //height: 12.h,
        padding: EdgeInsets.fromLTRB(4.w, 0.h, 0.w, 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 0.4.h,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(1.h),
                  bottomLeft: Radius.circular(1.h),
                ),
              ),
              child: Text(
                status,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: 20.w,
              ),
              width: 75.w,
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: FontConstants.comfortaaSemiBold,
                  color: ColorConstants.accentColor,
                  fontSize: 12.sp,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(
              height: 0.7.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.offersOrangeIcon,
                      height: 2.h,
                      width: 2.h,
                    ),
                    Text(
                      ' $offers offers',
                      style: TextStyle(
                        color: ColorConstants.accentColor,
                        fontSize: 9.sp,
                        fontFamily: FontConstants.comfortaaBold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.commentsOrangeIcon,
                      height: 2.h,
                      width: 2.h,
                    ),
                    Text(
                      ' $comments Comments',
                      style: TextStyle(
                        color: ColorConstants.accentColor,
                        fontSize: 9.sp,
                        fontFamily: FontConstants.comfortaaBold,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 4.w,
                  ),
                  width: 26.w,
                  height: 5.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorConstants.grayLevel8,
                      //onPrimary: ColorConstants.primaryColor,
                      onSurface: ColorConstants.primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      '\$ $price',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: ColorConstants.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.5.h,
            ),
          ],
        ),
      ),
    );
  }
}
