import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/dialog/dialog.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '/constants/font_constants.dart';
import '/widgets/my_appbar.dart';
import '/constants/color_constants.dart';
import '/data/dummy_data.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(hintText: 'Cài đặt'),
          Padding(
            padding: EdgeInsets.only(
              left: 3.w,
              right: 3.w,
              top: 2.5.h,
            ),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: opptionSetting.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return moreListTile(
                    icon: opptionSetting[index]['icon'],
                    title: opptionSetting[index]['title'],
                    url: opptionSetting[index]['screenLink'],
                  );
                }),
          ),
        ],
      ),
    );
  }

  clearPassword() async {
    var prefs = await SharedPreferences.getInstance();

    await prefs.remove('password');
  }

  Widget moreListTile(
      {required String icon,
      required String title,
      String? url,
      Function? onTap}) {
    return Card(
      elevation: 0,
      child: ListTile(
        dense: true,
        //visualDensity: VisualDensity.compact,
        onTap: () async {
          if (url == "/logout") {
            showCofirmDialogYN("Thông báo", "Bạn có muốn thoát không!!!",
                () async {
              await FirebaseAuth.instance.signOut();
              clearPassword();

              Get.offAllNamed("/login");
            });
          } else {
            if (url != null) {
              Get.toNamed(url);
            }
          }
        },
        minLeadingWidth: 4.w,
        leading: SvgPicture.asset(icon),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: FontConstants.comfortaaMedium,
            fontSize: 12.5.sp,
          ),
        ),
        trailing: SvgPicture.asset("assets/svgs/ic_arrow.svg"),
      ),
    );
  }
}
