import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

showIndicadorDialog(context) {
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

showCofirmDialog(String title, String content, {exit, String? textbutton}) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text(textbutton ?? "Đóng"),
          onPressed: () {
            if (exit != null) {
              exit();
            } else {
              Get.back();
              Get.back();
            }
          },
        )
      ],
    ),
    barrierDismissible: false,
  );
}

showCamreraOrLibary(String title, Function gotoCamera, Function gotoLibrary) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      actions: <Widget>[
        TextButton(
          child: Text("Thư viện ảnh"),
          onPressed: () {
            gotoLibrary();
            Get.back();
          },
        ),
        TextButton(
          child: Text("Camera"),
          onPressed: () {
            gotoCamera();
            Get.back();
          },
        ),
        TextButton(
          child: Text("Đóng"),
          onPressed: () {
            Get.back();
          },
        )
      ],
    ),
    barrierDismissible: false,
  );
}

showCreateOrSelect(String title, Function create, Function select) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      actions: <Widget>[
        TextButton(
          child: Text("Chọn phụ huynh"),
          onPressed: () {
            Get.back();
            select();
          },
        ),
        TextButton(
          child: Text("Tạo tài khoản phụ huynh"),
          onPressed: () {
            Get.back();
            create();
          },
        ),
        TextButton(
          child: Text("Đóng"),
          onPressed: () {
            Get.back();
          },
        )
      ],
    ),
    barrierDismissible: false,
  );
}

showCofirmDialogYN(String title, String content, Function accept) {
  Get.dialog(
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
    barrierDismissible: false,
  );
}
