import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/notificationModel.dart';
import 'package:tiendien_alias/pages/customer/chiTietBill/chiTietBillPage.dart';
import 'package:tiendien_alias/pages/customer/notifications/detailNotification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MessagingService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel channel;

  Future<void> loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          importance: Importance.high,
          showBadge: true);
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future<void> listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'logo',
            )));
      }
    });
  }

  Future<void> requestPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) async {
    if (message.data['type'] == 'notification' &&
        message.data['idNotification'] != "") {
      String id = message.data['idNotification'];
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(id)
          .get()
          .then((value) {
        NotificationModel notification =
            NotificationModel.fromJson(value.data()!);
        Get.to(() => DetailNotificationPage(notificationModel: notification));
      });
    }
  }

  Future<void> sendPushNotification(
      {required String title,
      required String body,
      required String token,
      required String idNotification}) async {
    if (token.isNotEmpty) {
      try {
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                "key=AAAAjcjcsqQ:APA91bEdftYUAyaAnfX3x--gnCQG8Lce_LFqJ_dT-K6DmglPy88-y8y9jXOA1gykIOjTPCSbH_G4kc4Qo7LmT-_KeTScngeMrsEkewb2CNqb9XG9kGFt4OuWE5Q6A1xw4qqkdGrFgDX4",
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': body,
                'title': title,
              },
              'priority': 'high',
              'content-available': 'true',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '1',
                'status': 'done',
                'type': 'notification',
                'idNotification': idNotification,
              },
              "to": token,
            },
          ),
        );
      } catch (e) {
        print("error push notification");
      }
    }
  }

  Future<void> sendNotification(
      {required String title,
      required String body,
      required String token}) async {
    if (token.isNotEmpty) {
      try {
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                "key=AAAAjcjcsqQ:APA91bEdftYUAyaAnfX3x--gnCQG8Lce_LFqJ_dT-K6DmglPy88-y8y9jXOA1gykIOjTPCSbH_G4kc4Qo7LmT-_KeTScngeMrsEkewb2CNqb9XG9kGFt4OuWE5Q6A1xw4qqkdGrFgDX4",
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': body,
                'title': title,
              },
              'priority': 'high',
              'content-available': 'true',
              'data': {},
              "to": token,
            },
          ),
        );
      } catch (e) {
        print("error push notification");
      }
    }
  }
}
