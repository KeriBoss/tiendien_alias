import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:flutter/material.dart';

class ColorPalette {
  static const primaryColor = Color(0xff5baeda);
  static const secondColor = Color(0xff017471);
  static const secondShadeColor = Color(0xff00b29c);

  static const Color titleColor = Color(0xff323B4B);
  static const Color subTitleColor = Color(0xff838383);
  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color backgroundScaffoldColor = Color(0xFFF2F2F2);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xFF121212);
  static const Color greenShade = Color(0xffecf4ef);
  static const Color orangeBoldColor = Color(0xffe84c3b);

  static const Color blueBoldColor = Color(0xFF22587A);
  static const Color blueLightColor = Color(0xFF38A3A6);
  static const Color greenMediumColor = Color(0xFF62C196);
  static const Color greenLightColor = Color(0xFF91CD91);

  // new
  static const Color greyColor = Color(0xffB1B1B1);
  static const Color backGroundColor = Color(0xffEAEAEA);
  static const Color errorColor = Color(0xffDD2222);
  static const Color borderColor = Color.fromRGBO(27, 42, 59, 0.1);

  static const BoxDecoration boxDecoration = BoxDecoration(
      gradient: LinearGradient(colors: [
    Color(0xff73B5E8),
    Color(0xffCDEEC7),
  ], stops: [
    0,
    0.5
  ], transform: GradientRotation(167)));

  static Widget getStatus(Status status) {
    if (status == Status.choMuaBill) {
      return Text(
        "Đang chờ bán",
        style: TextStyles.defaultStyle
            .setTextSize(12)
            .setColor(const Color(0xffCA6D00)),
      );
    } else {
      return Text(
        "Bán thành thông",
        style: TextStyles.defaultStyle
            .setTextSize(12)
            .setColor(const Color(0xff62C196)),
      );
    }
  }

  static UnderlineInputBorder underLineCyan = const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.cyan),
  );
  static UnderlineInputBorder underLineRed = const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent),
  );
}
