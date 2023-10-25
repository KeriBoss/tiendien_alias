import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaLog {
  static showIndicatorDialog() {
    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              )),
        ),
      ),
    );
  }
  static showConfirmDialogYN(
      {required String title,
        required String content,
        required Function accept,
        barrierDismissible = false,
        dissableBack = false}) {
    if (dissableBack == true) {
      Get.dialog(
        barrierDismissible: barrierDismissible,
        WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              const SizedBox(
                width: 10,
              ),
              TextButton(
                child: const Text("Đồng ý"),
                onPressed: () {
                  accept();
                },
              )
            ],
          ),
        ),
      );
    } else {
      Get.dialog(
        barrierDismissible: barrierDismissible,
        AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text("Đóng"),
              onPressed: () {
                Get.back();
              },
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
              child: const Text("Đồng ý"),
              onPressed: () {
                accept();
              },
            )
          ],
        ),
      );
    }
  }

}