import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/pages/admin/thanhkhoan/thanhKhoanController.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class XuLyNapTienPage extends StatelessWidget {
  ThanhKhoanController thanhKhoanController = Get.find();
  GiaoDichModel giaoDichModel = Get.arguments;
  final oCcy = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(hintText: 'Thông tin chuyển khoản'),
          const SizedBox(
            height: 16,
          ),
          giaoDichModel.image != ''
              ? Image.network(
                  giaoDichModel.image,
                  width: 70.w,
                  height: 50.h,
                  fit: BoxFit.fill,
                )
              : Container(
                  width: 70.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorPalette.blackColor),
                  ),
                  child: Center(
                    child: Text(
                      "Không có hình ảnh",
                      style: TextStyles.defaultStyle.setTextSize(18).medium,
                    ),
                  ),
                ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Số tiền muốn nạp: ${oCcy.format(num.parse(giaoDichModel.soTien))} VND",
            style: TextStyles.defaultStyle.setTextSize(18).medium,
          )
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
                child: IconButton(
                  icon: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () async {
                    thanhKhoanController.xacThuc(giaoDichModel);
                  },
                )),
            Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: IconButton(
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    thanhKhoanController.huy(giaoDichModel);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
