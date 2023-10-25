import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginToUse extends StatelessWidget {
  const LoginToUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Vui lòng đăng nhập để sử dụng dịch vụ'),
          SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () => Get.toNamed("/login"),
              child: const Text('Đăng nhập/Đăng ký'))
        ],
      )),
    );
  }
}
