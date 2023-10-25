import 'package:tiendien_alias/models/donHang.dart';
import 'package:tiendien_alias/pages/admin/home/homeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'giftBoxController.dart';

class GiftBoxPage extends StatelessWidget {
  final controller = Get.put(GiftBoxController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Điểm tích lũy"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/svgs/gifts.svg",
                width: 100.w,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Điểm tích lũy hiện tại: ",
                        style: Theme.of(context).textTheme.headlineMedium),
                    // TextSpan(text: homeController.currentUser.value!.diemTichLuy.toString(),
                    //     style: Theme.of(context).textTheme.headline6),
                  ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              controller.listDonHang.isNotEmpty
                  ? listItemDonHang()
                  : SizedBox(
                      height: 30.h,
                      child: Center(
                        child: Text(
                          "Hiện tại chưa có đơn hàng nào",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }

  Widget listItemDonHang() {
    return Obx(() {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.listDonHang.length,
        itemBuilder: (context, index) {
          DonHangModel donHang = controller.listDonHang[index];
          int diemTichLuy = int.parse(donHang.dichVu.gia) ~/ 10000;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            shadowColor: Colors.blue,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donHang.dichVu.ten,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${donHang.dichVu.gia} Xu",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donHang.ngayTao,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$diemTichLuy Điểm",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
