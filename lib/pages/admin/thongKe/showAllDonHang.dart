import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/donHang.dart';
import '../../../widgets/nameUser_widget.dart';
import 'thongKeController.dart';
import 'thongKePage.dart';
import 'package:intl/intl.dart';

class ShowAllDonHangPage extends StatelessWidget {
  ShowAllDonHangPage({Key? key}) : super(key: key);

  final controller = Get.put(ThongKeController());
  final oCcy = NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tất cả đơn hàng"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: listOrder(),
      ),
    );
  }

  Widget listOrder() {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.listDonHang.length,
        itemBuilder: (context, index) {
          DonHangModel donHang = controller.listDonHang[index];
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Tên Sản Phẩm: ${donHang.dichVu.ten}",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Khách: ",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        UserNameWidget(donHang.idKhach)
                      ],
                    ),
                    donHang.idTho != ""
                        ? Row(
                            children: [
                              Text(
                                "Thợ: ",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              UserNameWidget(donHang.idTho)
                            ],
                          )
                        : Container(),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Giá : ${oCcy.format(int.parse(donHang.dichVu.gia))} VNĐ",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Ngày bắt đầu làm: ${donHang.ngayBatDauLam.substring(0, 10)}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Trạng thái: ${donHang.trangThai}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 5,
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
