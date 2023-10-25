import 'package:carousel_slider/carousel_slider.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/customer/LoginToUse.dart';
import 'package:tiendien_alias/pages/customer/list_bill/listBillPage.dart';
import 'package:tiendien_alias/widgets/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../personal/personalPage.dart';
import 'home/homePage.dart';
import 'home_screen_controller.dart';

class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({Key? key}) : super(key: key);
  final CustomerHomeController _homeScreenController =
      Get.put(CustomerHomeController());
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        bottomNavigationBar: user != null ? BottomNavBar() : welcome(),
        body: _stackedWidgets(),
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (_homeScreenController.counter.value == 0) {
      return (await Get.dialog(
            AlertDialog(
              title: const Text(
                'Thông báo',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              content: const Text('Bạn muốn thoát ứng dụng?'),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.close(1);
                        SystemNavigator.pop();
                      },
                      child: const Text('Thoát '),
                    ),
                  ],
                )
              ],
            ),
          )) ??
          false;
    }
    _homeScreenController.isSelectedTask.value = false;
    _homeScreenController.isSelectedChat.value = false;
    _homeScreenController.isSelectedHome.value = true;
    _homeScreenController.isSelectedDots.value = false;
    _homeScreenController.counter.value = 0;
    return false;
  }

  Widget _stackedWidgets() {
    return Obx(
      () => IndexedStack(
        index: _homeScreenController.counter.value,
        children: [
          user != null ? const NoCurrentFunction() : const LoginToUse(),
          user != null ? ListBillPage() : const LoginToUse(),
          user != null ? CustomerHomeView() : const LoginToUse(),
          user != null ? const NoCurrentFunction() : const LoginToUse(),
          user != null ? PersonalPage() : const LoginToUse(),
        ],
      ),
    );
  }

  Widget welcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 3.h),
        Image.asset(
          "assets/pngs/logoPhoenix.png",
          height: 150,
          fit: BoxFit.fitHeight,
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: Text("Đăng nhập ",
                    style: TextStyles.defaultStyle.bold
                        .setColor(Colors.yellow.shade700)
                        .setTextSize(18))),
            Text(
              "hoặc ",
              style: TextStyles.defaultStyle.setTextSize(18),
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed('/signup');
                },
                child: Text("Đăng ký",
                    style: TextStyles.defaultStyle.bold
                        .setColor(Colors.yellow.shade700)
                        .setTextSize(18))),
          ],
        ),
        SizedBox(height: 3.h),
        Stack(
          children: [
            CarouselSlider.builder(
                itemCount: _homeScreenController.listImage.length,
                options: CarouselOptions(
                  height: 35.h,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  viewportFraction: 1,
                  onPageChanged: ((index, reason) {
                    _homeScreenController.currentIndex.value = index;
                  }),
                ),
                itemBuilder: (context, index, realIndex) {
                  final urlImage = _homeScreenController.listImage[index];
                  return Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(urlImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
            Obx(() => Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _homeScreenController.listImage.map((url) {
                      int index = _homeScreenController.listImage.indexOf(url);
                      return Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _homeScreenController.currentIndex.value == index
                                  ? const Color.fromRGBO(244, 243, 243, 1)
                                  : Colors.black26,
                        ),
                      );
                    }).toList(),
                  ),
                ))
          ],
        ),
      ],
    );
  }

  Widget callAPI() {
    return Container();
  }
}

class NoCurrentFunction extends StatelessWidget {
  const NoCurrentFunction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hiện tại chưa có chức năng',
            style: TextStyles.defaultStyle.bold.setTextSize(23),
          ),
          SizedBox(
            height: 10,
          ),
          // TextButton(
          //     onPressed: () => Get.toNamed("/login"),
          //     child: const Text('Đăng nhập/Đăng ký'))
        ],
      )),
    );
  }
}
