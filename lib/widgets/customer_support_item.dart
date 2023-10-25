import 'package:tiendien_alias/constants/app_images.dart';
import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/constants/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class CustomerSupportItem extends StatelessWidget {
  CustomerSupportItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.days,
      required this.status,
      required this.color})
      : super(key: key);
  final String title;
  final String description;
  final String days;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
          left: 3.w,
          right: 10.w,
          bottom: 1.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 0.45.h,
              ),
              margin: EdgeInsets.only(
                left: 28.w,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(0.7.h),
                  bottomLeft: Radius.circular(0.7.h),
                ),
              ),
              child: Text(
                status,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              children: [
                Container(
                  width: 50.w,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Text(
                  days + ' days ago',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: ColorConstants.accentColor,
                    fontFamily: FontConstants.comfortaaMedium,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              description,
              style: TextStyle(
                color: ColorConstants.lightBlack,
                fontFamily: FontConstants.comfortaaLight,
                fontSize: 10.5.sp,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              strutStyle: StrutStyle(
                height: 0.17.h,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              children: [
                Text(
                  'Attachments:',
                  style: TextStyle(
                    color: ColorConstants.lightBlack,
                    fontFamily: FontConstants.comfortaaBold,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  width: 15.w,
                  padding: EdgeInsets.all(
                    0.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.grayWhite,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        1.h,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        AppImages.fileIcon,
                      ),
                      Text(
                        ' File.PNG',
                        style: TextStyle(
                          fontSize: 7.sp,
                          fontFamily: FontConstants.comfortaaMedium,
                          color: ColorConstants.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  width: 15.w,
                  padding: EdgeInsets.all(
                    0.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.grayWhite,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        1.h,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        AppImages.fileIcon,
                      ),
                      Text(
                        ' File.PNG',
                        style: TextStyle(
                          fontSize: 7.sp,
                          fontFamily: FontConstants.comfortaaMedium,
                          color: ColorConstants.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
