import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'color_constants.dart';
import 'color_palette.dart';
import 'dimension_constants.dart';
import 'font_constants.dart';

ThemeData getAppThemeData() {
  return ThemeData(
    primaryColor: ColorPalette.primaryColor,
    scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorPalette.primaryColor,
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: ColorPalette.primaryColor,
      elevation: 2,
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: ColorPalette.whiteColor,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(color: Colors.white, size: 25),
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      labelStyle:
          TextStyles.defaultStyle.setTextSize(18).copyWith(fontFamily: 'Arial'),
      hintStyle: TextStyles.defaultStyle
          .setTextSize(16)
          .setColor(const Color(0xffB8B8B8)),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 2,
          color: ColorPalette.borderColor,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1.5, color: ColorPalette.borderColor),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1.5, color: Colors.red),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1.5, color: ColorPalette.borderColor),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1.5,
          //color: ColorPalette.subTitleColor
        ),
      ),
      errorStyle: const TextStyle(fontSize: 17),
    ),

    // Outlined button theme
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: OutlinedButton.styleFrom(
    //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    //     side: const BorderSide(color: ColorPalette.secondColor, width: 1),
    //     padding: EdgeInsets.symmetric(vertical: 2.3.h),
    //     minimumSize: Size(100.w, 5.h),
    //   ),
    // ),

    // Elevated buttom theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          shape:
              const RoundedRectangleBorder(borderRadius: kDefaultBorderRadius),
          padding: EdgeInsets.symmetric(vertical: 2.3.h),
          backgroundColor: ColorPalette.primaryColor,
          minimumSize: Size(100.w, 5.h)),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),

    iconTheme: const IconThemeData(
        color: ColorPalette.blackColor, size: kDefaultIconSize),

    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 22.5.sp,
        letterSpacing: -0.5,
        fontFamily: FontConstants.comfortaaBold,
        color: ColorConstants.appBlack,
      ),
      headline2: TextStyle(
        fontSize: 14.5.sp,
        letterSpacing: -0.5,
        fontFamily: FontConstants.comfortaaSemiBold,
        color: ColorConstants.lightGray,
      ),
      headline3: TextStyle(
        fontSize: 11.5.sp,
        //letterSpacing: -0.5,
        fontFamily: FontConstants.comfortaaBold,
        color: ColorConstants.lightGray,
      ),
      headline4: TextStyle(
        fontSize: 13.0.sp,
        fontWeight: FontWeight.bold,
        color: ColorPalette.primaryColor,
      ),
      headline5: TextStyle(
        fontSize: 11.sp,
        fontFamily: FontConstants.comfortaaBold,
        color: ColorPalette.primaryColor,
      ),
      headline6: TextStyle(
        fontSize: 11.sp,
        fontFamily: FontConstants.comfortaaSemiBold,
        color: ColorPalette.primaryColor,
      ),

      // TextField font
      subtitle1: const TextStyle(
        fontFamily: FontConstants.comfortaaBold,
      ),
      subtitle2: TextStyle(
        fontSize: 8.5.sp,
        fontFamily: FontConstants.comfortaaBold,
        color: ColorPalette.whiteColor,
      ),

      /// Using this style for radio button text and other place with 16.0.sp and #0d1111 color
      bodyText1: TextStyle(
        fontSize: 13.0.sp,
        fontFamily: FontConstants.comfortaaRegular,
        color: ColorConstants.appBlack,
      ),

      /// This style automatically applies on all the [Text]
      bodyText2: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w300,
        fontFamily: FontConstants.comfortaaMedium,
        color: ColorConstants.lightGray,
      ),

      /// This style automatically applies on the text of [ElevatedButton, OutlinedButton]
      /// also we can define different text style for these button in there respective
      /// theme data above
      button: TextStyle(
        fontSize: 12.5.sp,
        fontFamily: FontConstants.comfortaaBold,
        color: ColorConstants.accentColor,
      ),
    ),
  );
}
