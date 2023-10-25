import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/data/dummy_data.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/pages/khach_hang/my_bill/detail_my_bill/detail_my_bill_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:tiendien_alias/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'thong_ke_sell_controller.dart';

class ThongKeSellPage extends StatelessWidget {
  var controller = Get.put(ThongKeSellController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(hintText: 'Thống kê bán bill'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Obx(() {
                return item('Tổng tiền bill',
                    '${oCcy.format(controller.totalPrice.value)} VNĐ');
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Obx(() {
                return item('Tổng đơn',
                    "${oCcy.format(controller.listBill.length)} đơn");
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWidget(hintText: 'Ngày bắt đầu'),
                        TextFormField(
                          controller: controller.startDateController,
                          readOnly: true,
                          onTap: () async {
                            DateTime now = DateTime.now();
                            final date = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: DateTime(now.year),
                                lastDate: now);
                            if (date == null) return;
                            String formatDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            controller.startDateController.text = formatDate;
                            controller.startDate = date;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWidget(hintText: 'Ngày kết thúc'),
                        TextFormField(
                          readOnly: true,
                          controller: controller.endDateController,
                          onTap: () async {
                            DateTime now = DateTime.now();
                            final date = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: DateTime(now.year),
                                lastDate: now);
                            if (date == null) return;
                            String formatDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            controller.endDateController.text = formatDate;
                            controller.endDate =
                                date.add(const Duration(days: 1));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: SizedBox(
                height: 51,
                child: ButtonBlack(
                    hintText: "Lọc",
                    onPressed: () {
                      if (controller.endDate == null &&
                          controller.startDate == null) return;
                      if (controller.endDate!.isAfter(controller.startDate!)) {
                        controller.sortTime();
                      } else {
                        Get.defaultDialog(
                            title: 'Thông báo',
                            content: const Text(
                                "Ngày bắt đầu phải bé hơn ngày kết thúc"));
                      }
                    }),
              ),
            ),
            listNap(),
          ],
        ),
      ),
    );
  }

  Widget listNap() {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listBill.length,
        itemBuilder: (context, index) {
          BillModel billModel = controller.listBill[index];

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CircleAvatar(
                          maxRadius: 7,
                          backgroundColor: Colors.green,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                            DateFormat('dd/MM/yyyy').format(billModel.dateBill),
                            style: TextStyles.defaultStyle)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Người bán: ${billModel.username}",
                      style: TextStyles.defaultStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Đơn: ${billModel.id}",
                      style: TextStyles.defaultStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Số tiền: ${oCcy.format(billModel.price)} VNĐ",
                      style: TextStyles.defaultStyle,
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

  Widget item(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: const Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
