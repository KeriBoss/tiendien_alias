import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tiendien_alias/LTD/lib/Models/LoHang.dart';

import 'logic.dart';

class DanhSachDonHangPage extends StatelessWidget {
  final logic = Get.put(DanhSachDonHangLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Danh sách lô hàng"),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                // TextFormField(
                //   decoration: const InputDecoration(
                //     suffixIcon: Icon(
                //       Icons.search,
                //       size: 30,
                //       color: ColorPalette.primaryColor,
                //     ),
                //     hintText: "Tìm kiếm tên hoặc số điện thoại",
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
                //       borderSide: BorderSide(
                //         color: Colors.grey,
                //       ),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //       borderSide: BorderSide(color: ColorPalette.primaryColor),
                //     ),
                //   ),
                //   onChanged: (value) {
                //     logic.searchGa.value = value;
                //     logic.searchStringGa();
                //   },
                // ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: logic.listLoHang.value!.length,
                  itemBuilder: (context, index) {
                    LoHang loHang = logic.listLoHang[index];
                    String day =
                        DateFormat('dd-MM-yyyy').format(loHang.ngayGiao);
                    return InkWell(
                      onTap: () {
                        Get.toNamed("/danhsachdonhangtheolo",
                            arguments: loHang);
                      },
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.purpleAccent,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                    "Lô Hàng : ${loHang.maLoHang.toString()}"),
                                trailing: Text("Tạo :$day"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
