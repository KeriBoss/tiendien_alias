import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tiendien_alias/LTD/lib/Models/DinhMuc.dart';
import 'package:tiendien_alias/LTD/lib/validate/validate.dart';

import 'logic.dart';


class ThemDinhMucPage extends StatelessWidget {
  final logic = Get.put(ThemDinhMucLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thêm Định Mức"),),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: logic.key,
            child: InkWell(
              onTap: () {
                print("ff");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25,),
                  TextFormField(
                    controller: logic.soBo,
                    decoration: const InputDecoration(
                      hintText: "Số bộ",
                    ),
                    validator: (value) => validatorText(value!),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                  ),
                  // SizedBox(height: 15,),
                  // TextFormField(
                  //   controller: logic.soM,
                  //   decoration: const InputDecoration(
                  //     hintText: "Số m vải",
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // TextFormField(
                  //   controller: logic.soMMen,
                  //   decoration: const InputDecoration(
                  //     hintText: "Số m mền",
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // TextFormField(
                  //   controller: logic.soMGa,
                  //   decoration: const InputDecoration(
                  //     hintText: "Số m ga",
                  //   ),
                  // ),

                  const SizedBox(height: 25,),


                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            // logic.addDinhMuc(context);
                            if(logic.key.currentState!.validate()){
                              logic.addDinhMuc(context);
                            }
                          },
                          child: Text(
                            "Thêm",
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
                  SizedBox(height: 20,),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('DinhMuc').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return DataTable(
            columns: const [
              DataColumn(label: Text('Số bộ')),
              DataColumn(label: Text('Số M')),
              DataColumn(label: Text('Số ga')),
              DataColumn(label: Text('Số mền')),
            ],
            rows: _buildList(context, snapshot.data!.docs)
        );
      },
    );
  }




  List<DataRow> _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return  snapshot.map((data) => _buildListItem(context, data)).toList();
  }



  DataRow _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    final dinhMuc = DinhMuc.fromJson(data);

    return DataRow(cells: [
      DataCell(Text(dinhMuc.soBo.toString())),
      DataCell(Text(dinhMuc.soM.toString())),
      DataCell(Text(dinhMuc.soMGa.toString())),
      DataCell(Text(dinhMuc.soMMen.toString())),
    ]);
  }
}
