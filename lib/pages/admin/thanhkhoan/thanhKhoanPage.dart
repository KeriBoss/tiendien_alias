import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/admin/thanhkhoan/thanhKhoanController.dart';
import 'package:tiendien_alias/pages/admin/xuLyNapTien/xuLyNapTienPage.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/future_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../xuLyRutTien/xuLyRutTienPage.dart';

class ThanhKhoanPage extends GetView<ThanhKhoanController> {
  final oCcy = NumberFormat("#,##0", "en_US");

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
                        // IconButton(
                        //     onPressed: () {
                        //       showSearch(context: context, delegate: SearchViewRutTienDelegate());
                        //     },
                        //     icon: const Icon(Icons.search)
                        // )
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 16,
                    width: 16,
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
          Row(
            children: [
              Text(
                'Người dùng : ',
                style: TextStyles.defaultStyle.medium,
              ),
              NameUserWidget(napTienModel.idUser),
            ],
          ),
          const SizedBox(height: 10),
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
              child: GestureDetector(
                onTap: () {
                  if (giaoDichModel.trangThai == "Chờ xử lý") {
                    Get.to(() => XuLyNapTienPage(), arguments: giaoDichModel);
                  }
                },
                child: SwipeActionCell(
                    key: ObjectKey(giaoDichModel),
                    trailingActions: actionRutTien(context, giaoDichModel),
                    child: napTienItem(giaoDichModel, context)),
              ),
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
            child: GestureDetector(
              onTap: () {
                if (giaoDichModel.trangThai == "Chờ xử lý") {
                  Get.to(() => XuLyRutTienPage(), arguments: giaoDichModel);
                }
              },
              child: SwipeActionCell(
                  key: ObjectKey(giaoDichModel),
                  trailingActions: actionRutTien(context, giaoDichModel),
                  child: napTienItem(giaoDichModel, context)),
            ),
          );
        },
      );
    });
  }

  List<SwipeAction> actionNapTien(
      BuildContext context, GiaoDichModel giaoDichModel) {
    if (giaoDichModel.trangThai == "Chờ xử lý") {
      return <SwipeAction>[
        SwipeAction(
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
            icon: const Icon(
              Icons.close,
              color: ColorConstants.whiteColor,
            ),
            onTap: (CompletionHandler handler) async {
              controller.huy(giaoDichModel);
            },
            color: ColorConstants.redButtonBackground),
        SwipeAction(
            icon: const Icon(
              Icons.check,
              color: ColorConstants.whiteColor,
            ),
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
            onTap: (CompletionHandler handler) async {
              controller.xacThuc(giaoDichModel);
            },
            color: Colors.green),
      ];
    }

    if (giaoDichModel.trangThai == "Đã hủy") {
      return <SwipeAction>[
        SwipeAction(
            icon: const Icon(
              Icons.check,
              color: ColorConstants.whiteColor,
            ),
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
            onTap: (CompletionHandler handler) async {
              controller.xacThuc(giaoDichModel);
            },
            color: Colors.green),
      ];
    }
    return [];
  }

  List<SwipeAction> actionRutTien(
      BuildContext context, GiaoDichModel giaoDichModel) {
    if (giaoDichModel.trangThai == "Đã gửi - Chờ xác nhận") {
      return <SwipeAction>[
        SwipeAction(
            icon: const Icon(
              Icons.delete,
              color: ColorConstants.whiteColor,
            ),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
            onTap: (CompletionHandler handler) async {
              DiaLog.showDiaLogYN(
                  title: 'Thông báo',
                  content: "Bạn muốn huỷ giao dịch này?",
                  accept: () => controller.reject(giaoDichModel));
            },
            color: Colors.redAccent),
      ];
    }
    return [];
  }
}
