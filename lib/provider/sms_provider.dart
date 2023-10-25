import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SMSProvider {

  Future<void> sendSMS(String message, String phone) async {

    String url = "http://34.67.155.53:1234/api_upload-image/api_send_sms/sendsms.php?";

    String newPhone = "84${phone.substring(1,phone.length)}";

    var formData = dio.FormData.fromMap({
      "phone": newPhone,
      "sms": message,
    });

    final response = await (dio.Dio().post(
      url,
      data: formData,
      options:dio.Options(contentType:'application/json'),
    ));

    if (response.statusCode == 200) {
      print(newPhone);
      print(response.data);
      // Get.snackbar('Thông báo', "Đã gửi tin nhắn thành công",
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
    } else {
      throw Exception('Send sms failed');
    }


  }

}