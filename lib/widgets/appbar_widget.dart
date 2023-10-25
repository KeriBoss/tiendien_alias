import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget({Key? key, required this.hintText, this.suffixWidget})
      : super(key: key);

  final String hintText;
  Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ColorPalette.boxDecoration,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, top: 61, bottom: 20, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Get.close(1);
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                child: const Icon(Icons.arrow_back)),
            Text(
              hintText,
              style: TextStyles.defaultStyle.medium.setTextSize(18),
            ),
            suffixWidget != null ? suffixWidget! : const Text(" "),
          ],
        ),
      ),
    );
  }
}
