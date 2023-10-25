import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/notificationModel.dart';
import 'package:tiendien_alias/pages/customer/notifications/detailNotification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông báo')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('notifications')
              .where('idNguoiNhan',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .orderBy('createdTime', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                NotificationModel notificationModel =
                    NotificationModel.fromJson(data);
                return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailNotificationPage(
                          notificationModel: notificationModel));
                    },
                    child: buildNotifications(notificationModel));
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget buildNotifications(NotificationModel notificationModel) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(
              //   "assets/pngs/logo-shipper.png",
              //   width: 55,
              //   height: 55,
              //   fit: BoxFit.contain,
              // ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(notificationModel.title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18)),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(notificationModel.descriptionNguoiNhan,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 18)),
                    const SizedBox(height: 10),
                    Text(
                        DateFormat('dd/MM/yyyy hh:mm')
                            .format(notificationModel.createdTime),
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 2,
            color: Colors.blueGrey,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
