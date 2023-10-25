import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_palette.dart';
import '../../../constants/textstyle_ext.dart';

class BaoCaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: ColorPalette.secondShadeColor
                ),
                onPressed: (){}, 
                child: const Text("Đồng ý",)
            )
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Báo cáo chi tiết quan hệ tín dụng')),
      body: Column(
        children: [
          Text("Bạn có đồng ý điều khoản trên"),
        ],
      ),
    );
  }
}