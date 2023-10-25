import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/data/dummy_data.dart';
import 'package:tiendien_alias/models/electricityBill.dart';
import 'full_image_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'detail_bill_controller.dart';

class DetailBillPage extends StatelessWidget {
  var controller = Get.put(DetailBillController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(hintText: 'Chi tiết'),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 22),
            color: ColorPalette.backGroundColor,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: ColorPalette.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, bottom: 16),
                          child: infoBill(),
                        ),
                        Column(
                          children: [
                            headerTable(),
                            Obx(() {
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.historyPayment.value!
                                    .listElectricityBill.length,
                                itemBuilder: (context, index) {
                                  ElectricityBillModel electricityBill =
                                      controller.historyPayment.value!
                                          .listElectricityBill[index];
                                  return GestureDetector(
                                      onTap: () {
                                        Get.to(() => FullImagePage(),
                                            arguments: [
                                              electricityBill,
                                              controller.historyPayment.value!
                                            ]);
                                      },
                                      child: itemTable(electricityBill, index));
                                },
                              );
                            }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoBill() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Đơn - ${controller.historyPayment.value!.listElectricityBill.first.codeBill}",
          style: TextStyles.defaultStyle.medium.setTextSize(14),
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          children: [
            const Icon(
              Icons.circle,
              size: 7,
            ),
            const SizedBox(
              width: 5,
            ),
            Text("Giá trị đơn: ",
                style: TextStyles.defaultStyle.setTextSize(12)),
            Text(
                "${oCcy.format(controller.historyPayment.value!.totalBill)} VND",
                style: TextStyles.defaultStyle.setTextSize(12)),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          children: [
            const Icon(
              Icons.circle,
              size: 7,
            ),
            const SizedBox(
              width: 5,
            ),
            Text("Người thanh toán: ",
                style: TextStyles.defaultStyle.setTextSize(12)),
            Text(controller.historyPayment.value!.nameUser!,
                style: TextStyles.defaultStyle.setTextSize(12)),
          ],
        ),
      ],
    );
  }

  Widget headerTable() {
    return Row(
      children: [
        Container(
          width: 12.6.w,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "STT",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: 30.w,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "Mã hoá đơn",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: 24.4.w,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "Giá(000)",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: 33.w - 35,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "Trạng thái",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget itemTable(ElectricityBillModel electricityBill, int index) {
    index = index + 1;
    return Container(
      color: ColorPalette.backGroundColor,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12.6.w,
                height: 40,
                color: ColorPalette.whiteColor,
                child: Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: TextStyles.defaultStyle.setTextSize(12),
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Container(
                width: 30.w,
                height: 40,
                color: ColorPalette.whiteColor,
                child: Center(
                  child: Text(
                    "${electricityBill.codeBill.substring(0, 8)}...",
                    style: TextStyles.defaultStyle.setTextSize(12),
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Container(
                width: 24.4.w,
                height: 40,
                color: ColorPalette.whiteColor,
                child: Center(
                  child: Text(
                    oCcy.format(electricityBill.priceBill),
                    style: TextStyles.defaultStyle.setTextSize(12),
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Container(
                width: 33.w - 35,
                height: 40,
                color: ColorPalette.whiteColor,
                child: Center(
                  child: electricityBill.isPayment
                      ? Text("Đã thanh toán",
                          textAlign: TextAlign.center,
                          style: TextStyles.defaultStyle
                              .setTextSize(12)
                              .setColor(const Color(0xff91CD91)))
                      : Text("Chưa thanh toán",
                          textAlign: TextAlign.center,
                          style: TextStyles.defaultStyle
                              .setTextSize(12)
                              .setColor(const Color(0xffD9D9D9))),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 1,
          ),
        ],
      ),
    );
  }
}
