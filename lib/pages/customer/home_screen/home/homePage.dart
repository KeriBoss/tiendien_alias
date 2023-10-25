import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/text_styles.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/pages/customer/home_screen/home_screen_controller.dart';
import 'package:tiendien_alias/pages/customer/list_bill/listBillPage.dart';
import 'package:tiendien_alias/pages/main_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:sizer/sizer.dart';
import '../../addBill/addBillPage.dart';
import '../../baoCao/baoCaoPage.dart';
import '../../billPayment/billPaymentPage.dart';
import '../../householdPayment/householdPaymentPage.dart';
import 'homeController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CustomerHomeView extends GetView<CustomerHomeViewController> {
  CustomerHomeViewController controller = Get.put(CustomerHomeViewController());
  MainController mainController = Get.put(MainController());
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FirebaseAuth.instance.currentUser != null
                  ? DataIfLogined(controller: controller)
                  : const LoginIfNotAuth(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(color: Colors.grey.shade400, thickness: 1.5),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      iconTitle(
                          title: "Nạp tiền",
                          icon: Icons.login_outlined,
                          onTap: () {
                            Get.toNamed('/napTien');
                          }),
                      Container(
                        height: 40,
                        width: 195,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                  offset: const Offset(3, 4))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.monetization_on,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 5),
                            Obx(() {
                              return controller.currentUser.value != null
                                  ? Text(
                                      "${oCcy.format(controller.currentUser.value!.money)} đ",
                                      style: TextStyles.defaultStyle,
                                    )
                                  : Container();
                            })
                          ],
                        ),
                      ),
                      iconTitle(
                          title: "Rút tiền",
                          icon: Icons.monetization_on,
                          onTap: () async {
                            if (await controller.getBankCustomer() == true) {
                              Get.toNamed('/rutTien');
                            } else {
                              if (!controller.isOpenSnackBar.value) {
                                Get.snackbar(
                                  "Thông báo",
                                  "Bạn chưa cập nhập thông tin ngân hàng của bạn, "
                                      "Vui lòng cập nhập để sử dụng chức năng này",
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                  onTap: (snack) {
                                    controller.isOpenSnackBar.value = true;
                                  },
                                );
                              }
                            }
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: kIsWeb
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => HouseholdPaymentPage());
                        },
                        child: Container(
                          width: kIsWeb ? 14.w : 40.w,
                          height: kIsWeb ? 14.w : 40.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette.primaryColor),
                          child: Center(
                              child: Text(
                            "Thanh toán hộ",
                            style: TextStyles.defaultStyle.whiteTextColor,
                          )),
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(AlertDialog(
                            title: Text(
                              "Chọn dịch vụ bạn muốn",
                              style: TextStyles.defaultStyle.bold,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Get.snackbar("Thông báo",
                                          "Hiện tại chức năng này chưa có");
                                    },
                                    child: const Text("Vay trả góp")),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Get.snackbar("Thông báo",
                                          "Hiện tại chức năng này chưa có");
                                    },
                                    child: const Text("Thẻ tín dụng")),
                              ],
                            ),
                          ));
                        },
                        child: Container(
                          width: kIsWeb ? 14.w : 40.w,
                          height: kIsWeb ? 14.w : 40.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette.primaryColor),
                          child: Center(
                              child: Text("Dịch vụ tài chính",
                                  style:
                                      TextStyles.defaultStyle.whiteTextColor)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget iconTitle(
      {required String title,
      required IconData icon,
      required Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 4,
                      spreadRadius: 2,
                      offset: const Offset(3, 4))
                ]),
            child: Icon(icon, size: 25),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyles.defaultStyle.setTextSize(14),
          )
        ],
      ),
    );
  }

  Widget iconClick(String title, Widget image, onPress) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: SizedBox(
        height: 120,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image,
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: TextStyles.defaultStyle.semiBold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleBar(title) {
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
      width: Get.width,
      decoration: const BoxDecoration(color: Colors.white),
      child: Text(
        title,
        style: const TextStyle(
            color: ColorPalette.primaryColor,
            fontSize: 17,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget staff(context, url, name, khoa, desc) {
    return SizedBox(
      height: 400,
      width: 250,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: url,
                height: 250,
                width: 240,
                fit: BoxFit.cover,
              ),
              Text(name,
                  style: TextStyles.defaultStyle.bold
                      .setTextSize(20)
                      .copyWith(color: ColorPalette.primaryColor)),
              const SizedBox(
                height: 5,
              ),
              Text(khoa, style: TextStyles.defaultStyle.bold.setTextSize(18)),
              const SizedBox(
                height: 5,
              ),
              Text(
                desc,
                style: TextStyles.defaultStyle.bold.setTextSize(18),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tuVan(context, nameNV, noidungNV, nameKH, noiDungKH) {
    return SizedBox(
      width: 300,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.person),
                  Text(nameKH,
                      style: Theme.of(context).textTheme.headlineMedium!),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                color: const Color.fromARGB(255, 164, 222, 244),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    noiDungKH,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: const Color.fromARGB(255, 66, 129, 162)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(nameNV,
                      style: Theme.of(context).textTheme.headlineMedium!),
                  const Icon(Icons.person),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                color: const Color.fromARGB(255, 186, 224, 203),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    noidungNV,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: const Color.fromARGB(255, 66, 129, 162)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget comment(BuildContext context, String nameKH, String content) {
    return SizedBox(
      height: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.person),
                  Text(nameKH,
                      style: Theme.of(context).textTheme.headlineMedium!),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                color: const Color.fromARGB(255, 164, 222, 244),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    content,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: const Color.fromARGB(255, 66, 129, 162)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataIfLogined extends StatelessWidget {
  const DataIfLogined({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CustomerHomeViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Xin chào ",
                        style: TextStyles.defaultStyle.semiBold,
                      ),
                      Obx(() => Text(
                            controller.currentUser.value == null
                                ? ""
                                : "${controller.currentUser.value!.name.toCapitalize()} ",
                            style: TextStyles.defaultStyle.semiBold,
                          ))
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Chúc bạn một ngày tốt lành",
                    style: TextStyles.defaultStyle.semiBold,
                  ),
                ],
              ),
              Obx(() {
                return controller.currentUser.value != null &&
                        controller.currentUser.value!.urlAvatar.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: controller.currentUser.value!.urlAvatar,
                        imageBuilder: (context, imageProvider) => Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    controller.currentUser.value!.urlAvatar,
                                  ),
                                  fit: BoxFit.cover,
                                ))),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipOval(
                            child: Image.asset(
                          "assets/pngs/worker.png",
                          fit: BoxFit.cover,
                        )),
                      );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class LoginIfNotAuth extends StatelessWidget {
  const LoginIfNotAuth({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 30),
              child: Text('Hôm nay của bạn thế nào ?',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 22)),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
              color: ColorConstants.whiteColor,
              border: Border.all(
                color: ColorConstants.primaryColor,
                width: 1, //                   <--- border width here
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    'Hãy khám phá những dịch vụ với ưu đãi hấp dẫn ngay hôm nay!',
                    style: Theme.of(context).textTheme.titleLarge!),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width / 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPalette.primaryColor,
                        fixedSize: Size.infinite),
                    onPressed: () => Get.toNamed("/login"),
                    child: const Text(
                      'Đăng nhập  \nĐăng ký',
                      style: TextStyle(color: Colors.white, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
