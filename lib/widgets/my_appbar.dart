import 'package:tiendien_alias/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  late bool isBack;
  String? title;
  late bool isSearch;
  late List<String> icons;
  TextEditingController searchController = TextEditingController();

  MyAppBar(this.isBack, this.title, this.isSearch, this.icons);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: isBack
          ? Container(
              margin: EdgeInsets.only(
                left: 3.w,
                right: 2.w,
              ),
              child: GestureDetector(
                child: SvgPicture.asset(
                  AppImages.backArrow,
                  fit: BoxFit.scaleDown,
                ),
                onTap: () => Get.back(),
              ),
            )
          : const SizedBox(),
      actions: icons
          .map((e) => Container(
                padding: EdgeInsets.only(
                  right: 5.w,
                ),
                child: SvgPicture.asset(e),
              ))
          .toList(),
      titleSpacing: 0,
      leadingWidth: isBack ? 15.w : 4.w,
      title: Row(
        children: [
          title != null
              ? Container(
                  margin: EdgeInsets.only(
                    right: 2.w,
                  ),
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: isBack ? 12.sp : 14.sp,
                    ),
                  ),
                )
              : const SizedBox(),
          isSearch
              ? Container(
                  height: 5.h,
                  width: 69.w,
                  alignment: Alignment.bottomLeft,
                  child: TextField(
                    controller: searchController,
                    cursorColor: ColorConstants.accentColor,
                    cursorWidth: 1.5,
                    textAlignVertical: TextAlignVertical.bottom,
                    autofocus: true,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                        ),
                      ),
                      suffix: GestureDetector(
                        child: SvgPicture.asset(
                          AppImages.crossIcon,
                        ),
                        onTap: () => searchController.clear(),
                      ),
                      suffixIconColor: ColorConstants.gray,
                      fillColor: ColorConstants.lightGrayLow,
                      filled: true,
                      hintText: "Search",
                      hintStyle: const TextStyle(
                        color: ColorConstants.accentColor,
                      ),
                    ),
                    style: TextStyle(
                        color: ColorConstants.accentColor, fontSize: 11.sp),
                    //onChanged: (query) => updateSearchQuery(query),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
