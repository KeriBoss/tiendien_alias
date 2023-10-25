import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dichVuController.dart';
class DichVuPage extends StatelessWidget {

  final controller = Get.put(DichVuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dịch vụ')),
      body: Container(
        child: Text('DichVu Body'),
      ),
    );
  }
}