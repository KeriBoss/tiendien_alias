import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/notificationModel.dart';
import 'thongBaoController.dart';

class ThongBaoNVPage extends StatelessWidget {
  final controller = Get.put(ThongBaoNVController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Obx(() {
          return listNotification();
        }),
      ),
    );
  }

  Widget listNotification() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.listNotification.length,
      itemBuilder: (context, index) {
        NotificationModel notification = controller.listNotification[index];
        return
          // notification.descriptionNguoiGui != ""
          //   ? InkWell(
          //       onTap: () => Get.to(() => DetailOrderPage(),
          //           arguments: controller.listNotification[index].donHangModel),
          //       splashColor: Colors.transparent,
          //       child: SizedBox(
          //         child: Column(
          //           children: [
          //             Row(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Image.asset(
          //                   "assets/pngs/logo-shipper.png",
          //                   width: 55,
          //                   height: 55,
          //                   fit: BoxFit.contain,
          //                 ),
          //                 const SizedBox(
          //                   width: 10,
          //                 ),
          //                 Expanded(
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text(notification.title,
          //                           style: const TextStyle(
          //                               color: Colors.black,
          //                               fontWeight: FontWeight.normal,
          //                               overflow: TextOverflow.ellipsis,
          //                               fontSize: 18)),
          //                       const SizedBox(height: 10),
          //                       Text(notification.descriptionNguoiNhan,
          //                           style: const TextStyle(
          //                               fontWeight: FontWeight.normal,
          //                               fontSize: 18)),
          //                       const SizedBox(height: 10),
          //                       Text(notification.createdTime,
          //                           style: const TextStyle(
          //                               fontWeight: FontWeight.normal,
          //                               fontSize: 15)),
          //                     ],
          //                   ),
          //                 )
          //               ],
          //             ),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             const Divider(
          //               height: 2,
          //               color: Colors.blueGrey,
          //             ),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //           ],
          //         ),
          //       ),
          //     )
          //   :
          Container();
      },
    );
  }
}
