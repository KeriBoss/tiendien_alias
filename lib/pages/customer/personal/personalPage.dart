import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/pages/customer/ChangePassword/ChangePasswordPage.dart';
import 'package:tiendien_alias/pages/customer/notifications/notificationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/textstyle_ext.dart';
import 'personalController.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PersonalPage extends StatelessWidget {
  PersonalController controller = Get.put(PersonalController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text('Cá nhân')),
        body: Obx(() {
          return controller.currentUser.value != null
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(children: [
                          Center(
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xff2639d8),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 150 * .65,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                            bottomLeft: Radius.circular(12)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 20,
                                    left: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey.shade200,
                                      radius: 44,
                                      child: controller.currentUser.value!
                                                  .urlAvatar ==
                                              ""
                                          ? SvgPicture.asset(
                                              "assets/svgs/ic_profile.svg",
                                              height: 30,
                                              fit: BoxFit.contain)
                                          : CachedNetworkImage(
                                              imageUrl: controller
                                                  .currentUser.value!.urlAvatar,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: 88,
                                                width: 88,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      CircularProgressIndicator(
                                                value: progress.progress,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 5,
                                      left: 0,
                                      right: 0,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              controller.currentUser.value!.name
                                                  .toCapitalize(),
                                              style:
                                                  TextStyles.defaultStyle.bold,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 3),
                                            child: MySeparator(
                                              color: Colors.grey,
                                              height: 1,
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Xin chào",
                              style:
                                  TextStyles.defaultStyle.bold.setTextSize(20),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                            width: 100.w,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade300.withOpacity(0.8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Hồ sơ cá nhân",
                                  style: TextStyles.defaultStyle,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        iconTitle(
                                            title: "Thông tin cá nhân",
                                            image: const Icon(Icons.person),
                                            onTap: () {
                                              Get.toNamed('/profile');
                                            }),
                                        iconTitle(
                                            title: "Hợp đồng dịch vụ",
                                            image: const Icon(Icons
                                                .playlist_add_check_circle_sharp),
                                            onTap: () {}),
                                        iconTitle(
                                            title: "Liên kết ngân hàng",
                                            image: const Icon(
                                                Icons.account_balance),
                                            onTap: () {
                                              Get.toNamed('/wallet_page');
                                            }),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          width: 100.w,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade300.withOpacity(0.8),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/ic_profile.svg",
                                  height: 60,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Bạn chưa định danh tài khoản",
                                  style: TextStyles.defaultStyle.bold
                                      .setColor(Colors.red)
                                      .setTextSize(14),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Thông tin định danh giúp bảo vệ tài khoản, rút tiền và được \nmở các tính năng, nghiệp vụ nâng cao",
                                  style:
                                      TextStyles.defaultStyle.setTextSize(11),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.blueAccent.shade700,
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Định danh ngay",
                                      style: TextStyles
                                          .defaultStyle.whiteTextColor
                                          .setTextSize(15),
                                    )))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Thiết lập tài khoản",
                              style: TextStyles.defaultStyle,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  iconTitleRow(
                                      title: "Thông báo",
                                      icon: const Icon(Icons.notifications),
                                      onTap: () {
                                        Get.to(() => NotificationsPage());
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  iconTitleRow(
                                      title: "Giới thiệu ứng dụng",
                                      icon: const Icon(
                                        Icons.share,
                                        color: Colors.green,
                                      ),
                                      onTap: () {
                                        Get.toNamed('/chiaSe');
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  iconTitleRow(
                                      title: "Lịch sử giao dịch",
                                      icon: const Icon(
                                        Icons.history,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        Get.toNamed('/transactionHistory');
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  iconTitleRow(
                                      title: "Mật khẩu và bảo mật",
                                      icon: Icon(Icons.lock,
                                          color: Colors.indigoAccent.shade700),
                                      onTap: () {
                                        Get.toNamed('/changePassword');
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  iconTitleRow(
                                      title: "Thiết lập quyền riêng tư",
                                      icon: const Icon(Icons.settings,
                                          color: Colors.orange),
                                      onTap: () {}),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  iconTitleRow(
                                      title: "Thông tin ứng dụng",
                                      icon: Icon(Icons.info,
                                          color: Colors.blueAccent.shade400),
                                      onTap: () {}),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  iconTitleRow(
                                      title: "Đăng xuất",
                                      icon: const Icon(Icons.login,
                                          color: Colors.red),
                                      onTap: () async {
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          'token': "",
                                        });
                                        FirebaseAuth.instance.signOut();
                                        Get.offAllNamed("/login");
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Container();
        }),
      ),
    );
  }

  iconTitle(
      {required String title,
      required Widget image,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade100,
            ),
            child: Center(child: image),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 80,
            child: Text(
              title,
              style: TextStyles.defaultStyle.copyWith(height: 1.3),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  iconTitleRow(
      {required String title, required Icon icon, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyles.defaultStyle.bold,
          ),
        ],
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 3.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
