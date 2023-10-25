import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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

  static showDiaLogYN({
    required String title,
    required String content,
    required Function accept,
    barrierDismissible = false,
  }) {
    return Get.dialog(
      barrierDismissible: barrierDismissible,
      AlertDialog(
        title: Text(title),
        titleTextStyle:
            TextStyles.defaultStyle.setColor(Colors.blue).setTextSize(20),
        content: Text(content),
        contentTextStyle: TextStyles.defaultStyle,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                  onPressed: () {
                    Get.close(1);
                  },
                  child: Text(
                    "Không",
                    style: TextStyles.defaultStyle.setColor(Colors.redAccent),
                  )),
              SizedBox(
                width: 4.w,
              ),
              OutlinedButton(
                  onPressed: () {
                    accept();
                  },
                  child: Text(
                    "Xác nhận",
                    style: TextStyles.defaultStyle.setColor(Colors.green),
                  )),
            ],
          )
        ],
      ),
    );
  }

  static showDiaLogOke({
    required String title,
    required String content,
    required Function accept,
    barrierDismissible = false,
  }) {
    return Get.dialog(
      barrierDismissible: barrierDismissible,
      AlertDialog(
        title: Text(title),
        titleTextStyle:
            TextStyles.defaultStyle.setColor(Colors.blue).setTextSize(20),
        content: Text(content),
        contentTextStyle: TextStyles.defaultStyle,
        actions: [
          // TextButton(
          //     style: TextButton.styleFrom(
          //
          //     ),
          //     onPressed: () => accept(),
          //     child: Text(
          //       "Oke",
          //       style: TextStyles.defaultStyle.setColor(Colors.green),)
          // )

          OutlinedButton(
            onPressed: () => accept(),
            child: Text("Oke",
                style: TextStyles.defaultStyle.setColor(Colors.green)),
          ),
        ],
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
              child: const Text("Hủy "),
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
