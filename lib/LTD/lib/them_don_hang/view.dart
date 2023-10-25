import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:tiendien_alias/LTD/lib/constants/color_palette.dart';
import 'package:tiendien_alias/LTD/lib/constants/textstyle_ext.dart';
import 'package:tiendien_alias/LTD/lib/validate/validate.dart';

import 'logic.dart';

class ThemDonHangPage extends StatelessWidget {
  final logic = Get.put(ThemDonHangLogic());
  bool _status = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm đơn hàng"),
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: logic.key,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: logic.tenLoHang,
                    decoration: const InputDecoration(
                      hintText: "Tên lô hàng",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    controller: logic.maDH,
                    decoration: const InputDecoration(
                      hintText: "Mã hàng",
                    ),
                    // onChanged: (value) {
                    //   logic.maHang.value = value ;
                    // },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: logic.soXap,
                          decoration: const InputDecoration(
                            hintText: "Nhập số m",
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) => validatorText(logic.soXap.text),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          child: Text(
                            "Tiếp",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (logic.key.currentState!.validate()) {
                              print(logic.soXap.text.trim());
                              logic.addXap(
                                  double.parse(logic.soXap.text.trim()));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Obx(() => Row(
                        children: [
                          Expanded(
                              child: Text(
                            logic.listXap.join(", "),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          )),
                        ],
                      )),

                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Hình ảnh",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.image,
                            color: Colors.blue, size: 30),
                        onPressed: () async {
                          logic.selectedImage();
                        },
                      ),
                      Obx(
                        () => logic.file.value != null
                            ? Expanded(
                                child: Text(basename(logic.file.value!.path)))
                            : Container(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () async {
                            num sum = 0;
                            for (var item in logic.listXap) {
                              sum += item;
                            }
                            if (sum < 6.8) {
                              Get.defaultDialog(
                                  title: "Thông báo",
                                  content: Text("Tổng số M quá thấp"));
                            } else {
                              logic.listXap.isNotEmpty && logic.maDH.text != ""
                                  ? await logic.addList()
                                  : Get.snackbar(
                                      "Thông báo", "Vui lòng nhập đủ thông tin",
                                      backgroundColor: Colors.red);
                            }
                          },
                          child: Text(
                            "Thêm mã hàng mới",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () async {
                            await logic.deleteXap();
                          },
                          child: Text(
                            "X",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Obx(() => Text("Mã đơn hàng : ${logic.maHang.value}", style: TextStyle(color: Colors.black, fontSize: 20),),),
                  //     Obx(() => Row(
                  //       children: logic.listXap.value.map((e) {
                  //         return Text(e.toString() + " , ", style: const TextStyle(color: Colors.black, fontSize: 20),);
                  //       },).toList(),
                  //     )),
                  //     Obx(() {
                  //       return logic.sum.value != 0.0 ? Text("Tổng số M là : " + logic.sum.value.toString(),style: TextStyle(color: Colors.black, fontSize: 22),) : Container();
                  //     })
                  //   ],
                  // ),
                  //  Obx(() => logic.sum.value > 0 ? ElevatedButton(
                  //      onPressed: (){
                  //        //logic.addDonHang();
                  //      },
                  //
                  //      child: Text("Thêm đơn hàng", style: TextStyle(color: Colors.white),)) : Container())
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(() {
                      //biến đếm stt
                      int dem = 1;

                      return DataTable(
                          border: TableBorder.all(
                              width: 2,
                              color: ColorPalette.primaryColor,
                              borderRadius: BorderRadius.circular(12)),
                          columns: [
                            DataColumn(
                                label: Expanded(
                                    child: Text("STT",
                                        textAlign: TextAlign.center,
                                        style: TextStyles.defaultStyle
                                            .setTextSize(15)))),
                            DataColumn(
                                label: Expanded(
                                    child: Text("Danh sách mã hàng",
                                        textAlign: TextAlign.center,
                                        style: TextStyles.defaultStyle
                                            .setTextSize(15)))),
                            DataColumn(
                                label: Expanded(
                                    child: Text("Xóa",
                                        textAlign: TextAlign.center,
                                        style: TextStyles.defaultStyle
                                            .setTextSize(15))))
                          ],
                          rows: logic.listDonHang.value.map<DataRow>((donHang) {
                            //print(donHang.toJson());
                            return DataRow(cells: [
                              DataCell(Text((dem++).toString(),
                                  style:
                                      TextStyles.defaultStyle.setTextSize(15))),
                              DataCell(Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${donHang.maDH} , ${donHang.tongSoM.toStringAsFixed(2)} , ${donHang.dinhMuc.soBo} , ${donHang.vaiDu.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )),
                              DataCell(InkWell(
                                  onTap: () {
                                    logic.deleteDH(donHang);
                                  },
                                  child:
                                      const Center(child: Icon(Icons.delete)))),
                            ]);
                          }).toList());
                    }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (logic.listDonHang.value.isNotEmpty &&
                          logic.tenLoHang.text != "") {
                        logic.addDonHang();
                      } else {
                        Get.snackbar(
                            "Thông báo", "Vui lòng nhập đầy đủ thông tin",
                            backgroundColor: Colors.red);
                      }
                    },
                    child: Text(
                      "Hoàn tất đơn hàng",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
