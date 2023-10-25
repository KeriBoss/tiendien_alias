import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '/constants/color_constants.dart';

class MainController extends GetxController {
  Future<bool?> alertDialog(String detail, BuildContext context, {exit}) {
    return Alert(buttons: [
      DialogButton(
        color: ColorConstants.primaryColor,
        child: const Text(
          'Đóng',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Get.back();
          if (exit != null) {
            exit();
          }
        },
      ),
    ], context: context, desc: detail)
        .show();
  }

  showIndicadorDialog() {
    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
        ),
      ),
    );
  }

  showCofirmDialog(String title, String content, {exit}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text("Đóng"),
              onPressed: () {
                Get.back();
                Get.back();
                if (exit != null) {
                  exit();
                }
              },
            )
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
