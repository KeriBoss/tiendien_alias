import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../models/hoaDon.dart';
import '../../../widgets/nameUser_widget.dart';
import 'thongKeController.dart';

import 'package:intl/intl.dart';

class ShowAllHoaDonPage extends StatelessWidget {
  ShowAllHoaDonPage({Key? key}) : super(key: key);

  final controller = Get.put(ThongKeController());
  final oCcy = NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách hóa đơn"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: listHoaDon(),
      ),
    );
  }

  Widget listHoaDon() {
    return Obx(() {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.listHoaDon.length,
        itemBuilder: (context, index) {
          HoaDonModel hoaDon = controller.listHoaDon[index];
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x802196F3),
                          blurRadius: 5,
                          offset: Offset(3, 6))
                    ]),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text(hoaDon.createdDate,
                            style: Theme.of(context).textTheme.headline6)),
                    Row(
                      children: [
                        hoaDon.donHang.dichVu.hinhAnh != ""
                            ? CachedNetworkImage(
                                imageUrl: hoaDon.donHang.dichVu.hinhAnh,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/pngs/undraw_Photo_re_5blb.png",
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60.w,
                              child: Text(
                                  "Tên sản phẩm: ${hoaDon.donHang.dichVu.ten}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Khách: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                UserNameWidget(hoaDon.donHang.idKhach)
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Thợ: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                UserNameWidget(hoaDon.donHang.idTho)
                              ],
                            ),
                            Text(
                              "Ngày bắt đầu: ${hoaDon.donHang.ngayBatDauLam.split(" ")[0]}",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            // Text("Hoa hồng : ${hoaDon.hoaHong.soHoaHong}%",
                            //     style:
                            //         Theme.of(context).textTheme.headlineMedium),
                            Text(
                                "Tổng hóa đơn: ${oCcy.format(int.parse(hoaDon.donHang.dichVu.gia))} VNĐ",
                                style:
                                    Theme.of(context).textTheme.headlineMedium)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
