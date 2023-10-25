import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/customer.dart';
import 'package:tiendien_alias/pages/profile_qr/scan_qr/scan_qr_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:tiendien_alias/widgets/button_white.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import 'profile_qr_controller.dart';

class ProfileQRPage extends StatelessWidget {
  var controller = Get.put(ProfileQrController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang chủ"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
                onTap: () {
                  controller.createPdf(controller.currentUser.value!.phone);
                },
                child: const Icon(Icons.print)),
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: controller.tabController,
            labelColor: ColorPalette.primaryColor,
            unselectedLabelColor: ColorPalette.greyColor,
            tabs: const [
              Tab(
                text: 'Thông tin cá nhân',
              ),
              Tab(
                text: 'Bạn bè',
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                Obx(() {
                  return controller.currentUser.value != null
                      ? informationCurrentUser()
                      : Container();
                }),
                listFriend(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listFriend() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Tìm kiếm theo số điện thoại',
                      hintStyle: TextStyles.defaultStyle.medium),
                  onChanged: (value) {
                    controller.searchView(value);
                  },
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              InkWell(
                  onTap: () {
                    Get.to(() => const ScanQRPage());
                  },
                  child: const Icon(
                    Icons.qr_code,
                    size: 30,
                  )),
            ],
          ),
        ),
        Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listCustomer.length,
            itemBuilder: (context, index) {
              CustomerModel customer = controller.listCustomer[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    customer.avatar == ""
                        ? CircleAvatar(
                            backgroundColor: ColorPalette.backGroundColor,
                            backgroundImage: const AssetImage(
                              'assets/png/avatar_circle.png',
                            ),
                            maxRadius: 10.w,
                          )
                        : CircleAvatar(
                            backgroundColor: ColorPalette.backGroundColor,
                            backgroundImage: NetworkImage(customer.avatar),
                            maxRadius: 10.w,
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tên: ${customer.name}",
                          style: TextStyles.defaultStyle.setTextSize(14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Số điện thoại: ${customer.phone}",
                          style: TextStyles.defaultStyle.setTextSize(14),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget informationCurrentUser() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  controller.currentUser.value!.avatar == ""
                      ? CircleAvatar(
                          backgroundColor: ColorPalette.backGroundColor,
                          backgroundImage: const AssetImage(
                            'assets/png/avatar_circle.png',
                          ),
                          maxRadius: 19.w,
                        )
                      : CircleAvatar(
                          backgroundColor: ColorPalette.backGroundColor,
                          backgroundImage: NetworkImage(
                              controller.currentUser.value!.avatar),
                          maxRadius: 19.w,
                        ),
                  Positioned(
                    bottom: 1,
                    right: 5.w,
                    child: InkWell(
                        onTap: () {
                          Get.bottomSheet(showBottomSheetChooseAvatar());
                        },
                        child: Image.asset(
                          'assets/png/ic_edit_black.png',
                          width: 24,
                          height: 24,
                        )),
                  )
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Obx(() {
                return QrImageView(
                  data: controller.currentUser.value!.phone,
                  version: QrVersions.auto,
                  size: 150.0,
                );
              })
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          infoUser(),
          logOut(),
        ],
      ),
    );
  }

  Widget logOut() {
    return GestureDetector(
      onTap: () async {
        await FirebaseAuth.instance.signOut();
        Get.offAllNamed('/welcome');
      },
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 34),
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
        decoration: BoxDecoration(
            color: ColorPalette.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Đăng xuất",
              style: TextStyles.defaultStyle
                  .setColor(ColorPalette.errorColor)
                  .medium,
            ),
            Image.asset(
              'assets/png/ic_logout.png',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget infoUser() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
                color: ColorPalette.whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Họ và tên",
                  style: TextStyles.defaultStyle
                      .setColor(const Color(0xffB8B8B8))
                      .setTextSize(12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  controller.currentUser.value!.name,
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: ColorPalette.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Số điện thoại",
                  style: TextStyles.defaultStyle
                      .setColor(const Color(0xffB8B8B8))
                      .setTextSize(12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  controller.currentUser.value!.phone,
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: ColorPalette.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quốc tịch",
                  style: TextStyles.defaultStyle
                      .setColor(const Color(0xffB8B8B8))
                      .setTextSize(12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Việt Nam',
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
                color: ColorPalette.whiteColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Số CMT/CCCD",
                  style: TextStyles.defaultStyle
                      .setColor(const Color(0xffB8B8B8))
                      .setTextSize(12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  controller.currentUser.value!.cccd,
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showBottomSheetChooseAvatar() {
    return Container(
      decoration: const BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            "Thay đổi ảnh đại diện",
            style: TextStyles.defaultStyle.medium.setTextSize(18),
          ),
          const SizedBox(
            height: 26,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonBlack(
              hintText: 'Chụp ảnh',
              onPressed: () {
                Get.close(1);
                controller.pickerImageCamera();
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonWhite(
              hintText: 'Chọn từ thư viện',
              onPressed: () {
                Get.close(1);
                controller.pickerImageSource();
              },
            ),
          ),
          const SizedBox(
            height: 29,
          ),
        ],
      ),
    );
  }
}
