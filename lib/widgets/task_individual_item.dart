import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '/constants/app_images.dart';
import '/constants/color_constants.dart';
import '/constants/font_constants.dart';
import 'package:intl/intl.dart';

class TaskIndividualItem extends StatelessWidget {
  String title;
  String description;
  String status;
  String offers;
  String comments;

  TaskIndividualItem({
    Key? key,
    required this.title,
    required this.description,
    required this.status,
    required this.offers,
    required this.comments,
  }) : super(key: key);
  final oCcy = NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Card(
          margin: EdgeInsets.only(
            bottom: 3.5.w,
          ),
          elevation: 2,
          child: Container(
            width: 95.w,
            //height: 12.h,
            padding: EdgeInsets.fromLTRB(4.w, 1.5.h, 1.w, 0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 10,
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
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.bakery_dining_sharp,
                        )),
                  ],
                ),
                SizedBox(
                  height: 1.5.h,
                ),

                    Text(
                      ' $description ',
                      style: TextStyle(
                        color: ColorConstants.accentColor,
                        fontSize: 9.sp,
                        fontFamily: FontConstants.comfortaaBold,
                      ),
                    ),
                  

                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      oCcy.format(int.parse(offers)),
                      style: TextStyle(
                          color: ColorConstants.accentColor,
                          fontSize: 11.sp,
                          fontFamily: FontConstants.comfortaaBold,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      AppImages.iconMoney,
                      height: 2.h,
                      width: 2.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
