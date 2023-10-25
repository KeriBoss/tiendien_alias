import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/data/dummy_data.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/future_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'history_withdraw_controller.dart';

class HistoryWithdrawPage extends StatelessWidget {
  var controller = Get.put(HistoryWithDrawController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AppBarWidget(hintText: 'Thanh khoản'),
        const SizedBox(
          height: 16,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TabBar(
            controller: controller.tabController,
            labelColor: ColorPalette.blackColor,
            unselectedLabelColor: ColorPalette.greyColor,
            padding: const EdgeInsets.all(4),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorPalette.whiteColor,
            ),
            tabs: const [
              Tab(
                text: 'Nạp tiền',
              ),
              Tab(
                text: 'Rút tiền',
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: <Widget>[
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Trạng thái',
                          style: Theme.of(Get.context!)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          items: controller.listType
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          value: controller.listType.first,
                          onChanged: (value) {
                            if (value!.trim() == "All") {
                              controller.listNapTien.value =
                                  controller.listSourceNapTien;
                            } else {
                              controller.listNapTien.value = controller
                                  .listSourceNapTien
                                  .where((element) =>
                                      element.trangThai == value.trim())
                                  .toList();
                            }
                          },
                        ),
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       showSearch(context: context, delegate: SearchViewNapTienDelegate());
                      //     },
                      //     icon: const Icon(Icons.search)
                      // )
                    ],
                  ),
                  Expanded(child: listNapTien()),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Trạng thái',
                            style: Theme.of(Get.context!)
                                .textTheme
                                .headline4!
                                .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                            ),
                            items: controller.listType2
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem(
                                  value: value, child: Text(value));
                            }).toList(),
                            value: controller.listType.first,
                            onChanged: (value) {
                              if (value == "All") {
                                controller.listRutTien.value =
                                    controller.listSourceRutTien;
                              } else {
                                controller.listRutTien.value = controller
                                    .listSourceRutTien
                                    .where((element) =>
                                        element.trangThai == value!.trim())
                                    .toList();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    listRutTien(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget napTienItem(GiaoDichModel napTienModel, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 14,
                    width: 14,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(napTienModel.time),
                    style: TextStyles.defaultStyle.medium,
                  ),
                ],
              ),
              Text(
                napTienModel.trangThai,
                style: TextStyles.defaultStyle.medium,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${oCcy.format(int.parse(napTienModel.soTien))} đ",
            style: TextStyles.defaultStyle.medium,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget listNapTien() {
    return Obx(() {
      return SingleChildScrollView(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.listNapTien.value.length,
          itemBuilder: (context, index) {
            GiaoDichModel giaoDichModel = controller.listNapTien[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: napTienItem(giaoDichModel, context),
            );
          },
        ),
      );
    });
  }

  Widget listRutTien() {
    return Obx(() {
      return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.listRutTien.value.length,
        itemBuilder: (context, index) {
          GiaoDichModel giaoDichModel = controller.listRutTien[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: napTienItem(giaoDichModel, context),
          );
        },
      );
    });
  }
}
