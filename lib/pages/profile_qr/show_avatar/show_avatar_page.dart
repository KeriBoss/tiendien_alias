import 'dart:io';

import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:tiendien_alias/widgets/button_white.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'show_avatar_controller.dart';

class ShowAvatarPage extends StatelessWidget {
  var controller = Get.put(ShowAvatarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: Column(
        children: [
          AppBarWidget(hintText: 'Ảnh hồ sơ'),
          SizedBox(
            height: 14.h,
          ),
          Obx(() => CircleAvatar(
                backgroundImage: FileImage(File(controller.imagePath.value)),
                maxRadius: 37.w,
              )),
        ],
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 6.h,
        margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 24),
        child: Row(
          children: [
            Expanded(
                child: ButtonWhite(
                    hintText: 'Chụp lại',
                    onPressed: () {
                      controller.pickerImageCamera();
                    })),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: ButtonBlack(
                    hintText: 'Xong',
                    onPressed: () {
                      controller.saveAvatar();
                    })),
          ],
        ),
      ),
    );
  }
}
