import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/Users.dart';
import 'package:tiendien_alias/LTD/lib/Page/Widgets/GiaCong.dart';
import 'package:tiendien_alias/LTD/lib/constants/color_palette.dart';

import 'logic.dart';

class DanhSachNhanVienPage extends StatelessWidget {
  final logic = Get.put(DanhSachNhanVienLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách gia công"),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    size: 30,
                    color: ColorPalette.primaryColor,
                  ),
                  hintText: "Tìm kiếm tên hoặc số điện thoại",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: ColorPalette.primaryColor),
                  ),
                ),
                onChanged: (value) {
                  logic.searchGa.value = value;
                  logic.searchStringGa();
                },
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: logic.listUserGa.value!.length,
                itemBuilder: (context, index) {
                  UserModelLTD userModel = logic.listUserGa[index];
                  return NhanvienGiaCong(
                    userModel: userModel,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
