import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ButtonBlack extends StatelessWidget {
  const ButtonBlack({Key? key, required this.hintText, required this.onPressed})
      : super(key: key);

  final String hintText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100.w,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: ColorPalette.blackColor,
        ),
        child: Center(
            child: Text(
          hintText,
          style: TextStyles.defaultStyle.medium.whiteTextColor,
        )),
      ),
    );
  }
}
