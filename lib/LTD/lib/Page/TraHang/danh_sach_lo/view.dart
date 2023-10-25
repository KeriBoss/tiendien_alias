import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tiendien_alias/LTD/lib/Models/LoHang.dart';
import 'package:tiendien_alias/LTD/lib/Page/TraHang/danh_sach_don_hang/view.dart';

import 'logic.dart';

class DanhSachLoPage extends StatelessWidget {
  DanhSachLoPage({Key? key}) : super(key: key);

  final logic = Get.put(DanhSachLoLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Danh sách lô hàng đang trả"),),
        body: Obx(() => Column(
          children: [
            SizedBox(height: 10,),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: logic.listLoHang.value!.length,
              itemBuilder: (context, index) {
                LoHang loHang = logic.listLoHang[index];
                String day = DateFormat('dd-MM-yyyy').format(loHang.ngayGiao);
                return InkWell(
                  onTap: (){
                    Get.to(()=> DanhSachDonHangPage(), arguments: loHang);
                  },
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Lô Hàng : ${loHang.maLoHang.toString()}"),
                        trailing: Text("Ngày tạo :$day"),
                      ),
                      const Divider(height: 1, color: Colors.black,)
                    ],
                  ),
                );
              },
            )
          ],
        ),)
    );
  }
}
