import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/constants/color_palette.dart';
import 'package:tiendien_alias/LTD/lib/constants/textstyle_ext.dart';

import 'logic.dart';

class BangDinhMucPage extends StatelessWidget {
  final logic = Get.put(BangDinhMucLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bảng đinh mức"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => DataTable(
                        border: TableBorder.all(
                            width: 2,
                            color: ColorPalette.primaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        columns: [
                          DataColumn(
                              label: Expanded(
                                  child: Text("Số bộ",
                                      textAlign: TextAlign.center,
                                      style: TextStyles.defaultStyle
                                          .setTextSize(15)))),
                          DataColumn(
                              label: Expanded(
                                  child: Text("Số M vải",
                                      textAlign: TextAlign.center,
                                      style: TextStyles.defaultStyle
                                          .setTextSize(15)))),
                          DataColumn(
                              label: Expanded(
                                  child: Text("Số M mền",
                                      textAlign: TextAlign.center,
                                      style: TextStyles.defaultStyle
                                          .setTextSize(15)))),
                          DataColumn(
                              label: Expanded(
                                  child: Text("Số M ga",
                                      textAlign: TextAlign.center,
                                      style: TextStyles.defaultStyle
                                          .setTextSize(15)))),
                        ],
                        rows: logic.listDinhMuc.map<DataRow>((dinhMuc) {
                          return DataRow(cells: [
                            DataCell(Text(dinhMuc.soBo.toString(),
                                style:
                                    TextStyles.defaultStyle.setTextSize(15))),
                            DataCell(Text(
                                dinhMuc.soM.toString().length > 5
                                    ? dinhMuc.soM.toString().substring(0, 5)
                                    : dinhMuc.soM.toString(),
                                style:
                                    TextStyles.defaultStyle.setTextSize(15))),
                            DataCell(Text(
                                dinhMuc.soMMen.toString().length > 5
                                    ? dinhMuc.soMMen.toString().substring(0, 5)
                                    : dinhMuc.soMMen.toString(),
                                style:
                                    TextStyles.defaultStyle.setTextSize(15))),
                            DataCell(Text(
                                dinhMuc.soMGa.toString().length > 5
                                    ? dinhMuc.soMGa.toString().substring(0, 5)
                                    : dinhMuc.soMGa.toString(),
                                style:
                                    TextStyles.defaultStyle.setTextSize(15))),
                            // DataCell(Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: const [
                            //     //Text("Thành công", style: TextStyles.defaultStyle,),
                            //     //IconButton(onPressed: (){}, icon: Icon(Icons.check_circle, color: Colors.green,)),
                            //     //IconButton(onPressed: (){}, icon: Icon(Icons.cancel, color: Colors.redAccent,)),
                            //   ],
                            // )),
                          ]);
                        }).toList()),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
