import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/constants/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyTextStyle {
  static final header1 = TextStyle(
    fontFamily: FontConstants.comfortaaSemiBold,
    color: ColorConstants.accentColor,
    fontSize: 13.sp,
  );
  static final header2 = TextStyle(
      fontFamily: FontConstants.comfortaaSemiBold,
      color: ColorConstants.accentColor,
      fontSize: 11.sp,
      fontWeight: FontWeight.w300);
}
