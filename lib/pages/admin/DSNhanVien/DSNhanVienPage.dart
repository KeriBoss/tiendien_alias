import 'dart:convert';

import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/dialog/dialog.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/user.dart';
import 'package:tiendien_alias/pages/admin/DSNhanVien/DSNhanVienController.dart';
import 'package:tiendien_alias/pages/admin/thanhkhoan/thanhKhoanController.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DSNhanVienPage extends GetView<DSNhanVienController> {
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách nhân viên'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Get.toNamed("/taoTho"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  onFieldSubmitted: (value) =>
                      controller.timKiem(controller.textEditingController.text),
                  controller: controller.textEditingController,
                  decoration: InputDecoration(
                      hintText: "Tìm kiếm",
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: ColorConstants.blackShade,
                        ),
                        onPressed: () {
                          controller
                              .timKiem(controller.textEditingController.text);
                        },
                      )),
                ),
              ),
              Obx(
                () => list(),
              ),
            ],
          ),
        ));
  }

  Widget list() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.listNhanVien.length,
        itemBuilder: (context, index) {
          UserModel userModel = controller.listNhanVien[index];

          return SwipeActionCell(
              key: ObjectKey(userModel),

              ///this key is necessary

              child: InkWell(
                  onTap: () => {
                        Get.toNamed("/profileKHPage", arguments: [userModel])
                      },
                  child: Card(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            userModel.name + "",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text("SĐT : " + userModel.phone,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                          SizedBox(height: 5),
                          Text(
                            "Địa chỉ : " + userModel.address,
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        userModel.status,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  )));
        });
  }
}
