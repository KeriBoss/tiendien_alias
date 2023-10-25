import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/pages/admin/thong_ke/thong_ke_buy/thong_ke_buy_page.dart';
import 'package:tiendien_alias/pages/admin/thong_ke/thong_ke_nap/thong_ke_nap_page.dart';
import 'package:tiendien_alias/pages/admin/thong_ke/thong_ke_rut/thong_ke_rut_page.dart';
import 'package:tiendien_alias/pages/admin/thong_ke/thong_ke_sell/thong_ke_sell_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MenuThongKePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(hintText: 'Thống kê'),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: kIsWeb ? 5 : 3,
            children: [
              buttonIcon("Thống kê\nnạp", Icons.credit_card, () {
                Get.to(() => ThongKeNapPage());
              }),
              buttonIcon("Thống kê\nrút", Icons.credit_card, () {
                Get.to(() => ThongKeRutPage());
              }),
              buttonIcon("Thống kê\nbán bill", Icons.monetization_on_rounded,
                  () {
                Get.to(() => ThongKeSellPage());
              }),
              buttonIcon("Thống kê\nmua bill", Icons.monetization_on_rounded,
                  () {
                Get.to(() => ThongKeBuyPage());
              }),
            ],
          ),
        ],
      ),
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
}
