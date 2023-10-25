import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/font_constants.dart';
import 'package:tiendien_alias/constants/text_styles.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/admin/ManagementUser/managementUserPage.dart';
import 'package:tiendien_alias/pages/admin/config_contact/config_contact_page.dart';
import 'package:tiendien_alias/pages/admin/show_buy_bill/show_buy_bill_page.dart';
import 'package:tiendien_alias/pages/admin/thong_ke/menu_thong_ke.dart';
import 'package:tiendien_alias/pages/admin/thong_ke/thong_ke_nap/thong_ke_nap_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'homeController.dart';
import 'package:ionicons/ionicons.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends GetView<HomeController> {
  Future<bool> onWillPop() async {
    return (await Get.dialog(
          AlertDialog(
            title: const Text(
              'Thông báo',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            content: const Text('Bạn muốn thoát ?'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Không'),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.close(1);
                      SystemNavigator.pop();
                    },
                    child: const Text('Thoát '),
                  ),
                ],
              )
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                ListTile(
                  leading: Image.asset(
                      "assets/pngs/undraw_Profile_details_re_ch9r.png"),
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Xin chào ",
                            style: MyTextStyle.header1,
                          ),
                          Obx(() => Text(
                                controller.currentUser.value == null
                                    ? ""
                                    : "${controller.currentUser.value!.name}",
                                style: MyTextStyle.header1,
                              )),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "Chúc bạn một ngày tốt lành :3",
                    style: TextStyle(
                      fontFamily: FontConstants.comfortaaLight,
                      color: ColorConstants.accentColor,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                const Divider(
                  color: ColorConstants.primaryColor,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "assets/pngs/undraw_Teaching_re_g7e3.png",
                  height: Get.height / 3.5,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Divider(
                  thickness: 2,
                  color: ColorConstants.primaryColor,
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: kIsWeb ? 5 : 3,
                  children: [
                    buttonIcon("Nạp / Rút", Icons.credit_card, () {
                      Get.toNamed("/thanhKhoan");
                    }),
                    buttonIcon("Tài khoản", Icons.person, () {
                      Get.to(() => ManagementUserPage());
                    }),
                    buttonIcon("Hoa hồng", Icons.alarm, () {
                      Get.toNamed("/hoaHong");
                    }),
                    buttonIcon("Quản lý\nquảng cáo", Ionicons.megaphone, () {
                      Get.toNamed("/banner");
                    }),
                    buttonWidgetIcon("Xem bill\nthanh toán", Obx(() {
                      return controller.length > 0
                          ? badges.Badge(
                              position: badges.BadgePosition.topEnd(
                                  top: -10, end: -10),
                              badgeContent: Obx(() {
                                return Text(
                                  controller.length.value.toString(),
                                  style: TextStyles.defaultStyle.whiteTextColor
                                      .setTextSize(14),
                                );
                              }),
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.square,
                                badgeColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                borderRadius: BorderRadius.circular(16),
                                elevation: 0,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.history,
                                  color: ColorConstants.whiteColor,
                                  size: kIsWeb ? 3.w : 30,
                                ),
                              ))
                          : Icon(
                              Icons.history,
                              color: ColorConstants.whiteColor,
                              size: kIsWeb ? 3.w : 30,
                            );
                    }), () {
                      Get.to(() => ShowBuyBillPage());
                    }),
                    buttonIcon("Thống kê", Icons.bar_chart, () {
                      Get.to(() => MenuThongKePage());
                    }),
                    buttonIcon("Cấu hình\nliên hệ", Icons.support_agent, () {
                      Get.to(() => ConfigContactPage());
                    }),
                    buttonIcon("Cài đặt", Icons.settings, () {
                      Get.toNamed("/setting");
                    }),
                  ],
                ),
              ]),
        ),
      )),
    );
  }

  Widget buttonIcon(title, icon, onPress) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPress,
          child: Container(
            width: kIsWeb ? 7.w : 15.w,
            height: kIsWeb ? 7.w : 15.w,
            decoration: BoxDecoration(
                color: ColorPalette.secondShadeColor,
                borderRadius: BorderRadius.circular(25)),
            child: Icon(
              icon,
              color: ColorConstants.whiteColor,
              size: kIsWeb ? 3.w : 30,
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(Get.context!).textTheme.titleLarge,
        ),
      ],
    );
  }

  Widget buttonWidgetIcon(title, icon, onPress) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPress,
          child: Container(
            width: kIsWeb ? 7.w : 15.w,
            height: kIsWeb ? 7.w : 15.w,
            decoration: BoxDecoration(
                color: ColorPalette.secondShadeColor,
                borderRadius: BorderRadius.circular(25)),
            child: icon,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(Get.context!).textTheme.titleLarge,
        ),
      ],
    );
  }
}
