import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '/constants/font_constants.dart';
import '/widgets/my_appbar.dart';
import '/constants/color_constants.dart';
import '/data/dummy_data.dart';
import 'package:get/get.dart';

class MoreOptionsScreen extends StatelessWidget {
  const MoreOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grayLevel6,
      appBar: MyAppBar(false, 'Cài đặt', false, []),
      body: Padding(
        padding: EdgeInsets.only(
          left: 3.w,
          right: 3.w,
          top: 2.5.h,
        ),
        child: ListView.builder(
            itemCount: moreListTileData.length,
            itemBuilder: (context, index) {
              return moreListTile(
                icon: moreListTileData[index]['icon'],
                title: moreListTileData[index]['title'],
                url: moreListTileData[index]['screenLink'],
              );
            }),
      ),
    );
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
        onTap: () {
          if (url == "/logout") {
            FirebaseAuth.instance.signOut();
            Get.offAllNamed("/login");
          } else {
            if (url != "") {
              Get.toNamed(url!);
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
