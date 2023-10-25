import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/notification.dart';
import 'package:tiendien_alias/pages/khach_hang/notification/detail_expired/detail_expired_page.dart';
import 'package:tiendien_alias/pages/khach_hang/notification/detail_notification_point/detail_notification_point_page.dart';
import 'package:tiendien_alias/pages/khach_hang/notification/detail_notification_vnd/detail_notification_vnd_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'notification_controller.dart';

class NotificationPage extends StatelessWidget {
  var controller = Get.put(NotificationController());
  final oCcy = NumberFormat("#,##0", 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: ColorPalette.boxDecoration,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 61, bottom: 20, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Thông báo',
                            style:
                                TextStyles.defaultStyle.medium.setTextSize(18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 100.w,
              height: 100.h - 162,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 18),
              decoration: const BoxDecoration(
                color: ColorPalette.backGroundColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return titleText(
                          hintText:
                              "Mới nhất (${controller.listNotificationNew.value.where((p0) => p0.isView == false).length} chưa học)");
                    }),
                    Obx(() {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.listNotificationNew.length,
                        itemBuilder: (context, index) {
                          NotificationModel notification =
                              controller.listNotificationNew[index];
                          int stt = 0;
                          if (controller.listNotificationNew.length == 1) {
                            stt = 0;
                          }
                          if (controller.listNotificationNew.length == 2) {
                            int last =
                                controller.listNotificationNew.length - 1;
                            if (index == 0) {
                              stt = 1;
                            }
                            if (last == index) {
                              stt = 3;
                            }
                          }
                          if (controller.listNotificationNew.length > 2) {
                            int last =
                                controller.listNotificationNew.length - 1;
                            if (index == 0) {
                              stt = 1;
                            } else if (last == index) {
                              stt = 3;
                            } else {
                              stt = 2;
                            }
                          }
                          return InkWell(
                              onTap: () async {
                                if (notification.typePrice ==
                                    TypePrice.nothing) {
                                  Get.to(() => DetailExpiredPage(),
                                      arguments: notification);
                                  await FirebaseFirestore.instance
                                      .collection('notification')
                                      .doc(notification.id)
                                      .update({'isView': true});
                                } else {
                                  if (notification.bill != null) {
                                    Get.to(() => DetailNotificationVndPage(),
                                        arguments: [
                                          notification,
                                          notification.bill
                                        ]);
                                    await FirebaseFirestore.instance
                                        .collection('notification')
                                        .doc(notification.id)
                                        .update({'isView': true});
                                  } else {
                                    Get.to(() => DetailNotificationPointPage(),
                                        arguments: notification);
                                    await FirebaseFirestore.instance
                                        .collection('notification')
                                        .doc(notification.id)
                                        .update({'isView': true});
                                  }
                                }
                              },
                              child: itemNotification(notification, stt));
                        },
                      );
                    }),
                    titleText(hintText: "Cũ hơn"),
                    Obx(() {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.listNotificationOld.length,
                        itemBuilder: (context, index) {
                          NotificationModel notification =
                              controller.listNotificationOld[index];
                          int stt = 0;
                          if (controller.listNotificationOld.length == 1) {
                            stt = 0;
                          }
                          if (controller.listNotificationOld.length == 2) {
                            int last =
                                controller.listNotificationOld.length - 1;
                            if (index == 0) {
                              stt = 1;
                            }
                            if (last == index) {
                              stt = 3;
                            }
                          }
                          if (controller.listNotificationOld.length > 2) {
                            int last =
                                controller.listNotificationOld.length - 1;
                            if (index == 0) {
                              stt = 1;
                            } else if (last == index) {
                              stt = 3;
                            } else {
                              stt = 2;
                            }
                          }
                          return InkWell(
                              onTap: () async {
                                if (notification.typePrice ==
                                    TypePrice.nothing) {
                                  Get.to(() => DetailExpiredPage(),
                                      arguments: notification);
                                  await FirebaseFirestore.instance
                                      .collection('notification')
                                      .doc(notification.id)
                                      .update({'isView': true});
                                } else {
                                  if (notification.bill != null) {
                                    Get.to(() => DetailNotificationVndPage(),
                                        arguments: [
                                          notification,
                                          notification.bill
                                        ]);
                                    await FirebaseFirestore.instance
                                        .collection('notification')
                                        .doc(notification.id)
                                        .update({'isView': true});
                                  } else {
                                    Get.to(() => DetailNotificationPointPage(),
                                        arguments: notification);
                                    await FirebaseFirestore.instance
                                        .collection('notification')
                                        .doc(notification.id)
                                        .update({'isView': true});
                                  }
                                }
                              },
                              child: itemNotification(notification, stt));
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleText({required String hintText}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Text(
        hintText,
        style: TextStyles.defaultStyle.medium,
      ),
    );
  }

  Widget itemNotification(NotificationModel notification, int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: notification.isView
            ? ColorPalette.whiteColor
            : const Color(0xffF1FFF2),
        borderRadius: getBorderRadius(index),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          notification.isView == false
              ? Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12, top: 2),
                      child: Text(
                        notification.title,
                        style: TextStyles.defaultStyle.medium,
                      ),
                    ),
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: ColorPalette.errorColor,
                        maxRadius: 4,
                      ),
                    )
                  ],
                )
              : Text(
                  notification.title,
                  style: TextStyles.defaultStyle.medium,
                ),
          const SizedBox(
            height: 4,
          ),
          notification.typePrice.name != 'nothing'
              ? RichText(
                  text: TextSpan(children: [
                  TextSpan(
                      text: notification.body,
                      style: TextStyles.defaultStyle.setTextSize(12)),
                  TextSpan(
                      text:
                          ": ${notification.typeNotification == TypeNotification.buyPoints ? "+" : "-"}${oCcy.format(notification.price)} ",
                      style: TextStyles.defaultStyle
                          .setTextSize(12)
                          .setColor(notification.typeNotification ==
                                  TypeNotification.buyPoints
                              ? const Color(0xff62C196)
                              : ColorPalette.errorColor)
                          .copyWith(
                              fontWeight: notification.isView
                                  ? FontWeight.w400
                                  : FontWeight.w600)),
                  TextSpan(
                      text: notification.typePrice == TypePrice.point
                          ? 'point'
                          : "VND",
                      style: TextStyles.defaultStyle.setTextSize(12)),
                ]))
              : Text(notification.body,
                  style: TextStyles.defaultStyle.setTextSize(12)),
          const SizedBox(
            height: 4,
          ),
          Text(
            DateFormat('dd/MM/yyyy HH:mm').format(notification.createdDate),
            style: TextStyles.defaultStyle.setTextSize(12),
          ),
        ],
      ),
    );
  }

  BorderRadius getBorderRadius(int index) {
    if (index == 1) {
      return const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      );
    }
    if (index == 2) {
      return BorderRadius.circular(0);
    }
    if (index == 3) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }
    return BorderRadius.circular(8);
  }
}
