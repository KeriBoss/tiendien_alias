import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/admin/managementUser/verifiedCCCD/verifiedCCCDPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'managementUserController.dart';

class ManagementUserPage extends StatelessWidget {
  final logic = Get.put(ManagementUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backGroundColor,
      body: Column(
        children: [
          Container(
            decoration: ColorPalette.boxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 61, bottom: 20, right: 16),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.close(1);
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          child: const Icon(Icons.arrow_back)),
                      const SizedBox(
                        width: 70,
                      ),
                      Text(
                        'Tài khoản',
                        style: TextStyles.defaultStyle.medium.setTextSize(18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Tìm kiếm theo tên',
                  hintStyle: TextStyles.defaultStyle.medium),
              onChanged: (value) => logic.searchView(value),
            ),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: logic.listUser.length,
                itemBuilder: (context, index) {
                  UserModel userModel = logic.listUser[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => VerifiedCCCDPage(), arguments: userModel);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorPalette.whiteColor),
                      child: ListTile(
                        title: Text(
                          userModel.name,
                          style: TextStyles.defaultStyle,
                        ),
                        subtitle: Text(userModel.verified
                            ? "Đã xác thực"
                            : "Chưa xác thực"),
                        trailing: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: userModel.verified
                                  ? Colors.green
                                  : Colors.red),
                        ),
                        leading: const SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            child: Icon(Icons.person_outline),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
