import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tiendien_alias/LTD/lib/DiaLog.dart';
import 'package:tiendien_alias/LTD/lib/Firebase/Firebase_Auth.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/Page/TraHang/danh_sach_lo/view.dart';
import 'package:tiendien_alias/LTD/lib/constants/color_constants.dart';
import 'package:tiendien_alias/LTD/lib/constants/color_palette.dart';

import 'logic.dart';

enum SampleItem { itemdangxuat, doimatkhau, xoataikhoan }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuthen firebaseAuthen = FirebaseAuthen();

  final logic = Get.put(HomeLogic());
  Future<bool> onWillPop() async {
    return (await Get.dialog(
          AlertDialog(
            title: const Text(
              'Thông báo?',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            content: const Text('Bạn có muốn thoát ứng dụng không?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Không'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Có'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    SampleItem? selectedMenu;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<SampleItem>(
              initialValue: selectedMenu,
              // Callback that sets the selected popup menu item.
              onSelected: (SampleItem item) {
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
                PopupMenuItem<SampleItem>(
                  value: SampleItem.itemdangxuat,
                  child: const Text('Đăng xuất'),
                  onTap: () {
                    FirebaseAuthen().signOut(context);
                  },
                ),
                PopupMenuItem<SampleItem>(
                  value: SampleItem.doimatkhau,
                  child: const Text('Đổi mật khẩu'),
                  onTap: () {
                    Future.delayed(
                      Duration.zero,
                      () {
                        Get.toNamed("/doimatkhau");
                      },
                    );
                  },
                ),
                PopupMenuItem<SampleItem>(
                  value: SampleItem.xoataikhoan,
                  child: const Text('Xóa tài khoản'),
                  onTap: () {
                    DiaLog.showConfirmDialogYN(
                        title: "Thông báo",
                        content: "Bạn có chắc muốn xóa tài khoản này không?",
                        accept: () {});
                  },
                ),
              ],
            ),
          ],
        ),
        drawer: buildDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 30.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.1),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/background.jpg"),
                      fit: BoxFit.cover,
                    )),
                child: Stack(
                  children: [
                    CarouselSlider.builder(
                        itemCount: logic.listImage.length,
                        options: CarouselOptions(
                          height: 45.h,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          viewportFraction: 1,
                          onPageChanged: ((index, reason) {
                            logic.currentIndex.value = index;
                          }),
                        ),
                        itemBuilder: (context, index, realIndex) {
                          final urlImage = logic.listImage[index];
                          return Container(
                            width: 100.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(urlImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    iconClick(
                        'Thêm lô hàng',
                        "",
                        Icon(
                          Icons.add_chart,
                          size: 40,
                        ), () {
                      Get.toNamed('/themdonhangltd');
                    }),
                    iconClick(
                        'Danh sách lô hàng',
                        "",
                        const Icon(
                          Icons.list_alt,
                          size: 40,
                        ), () {
                      Get.toNamed("/danhsachdonhangltd");
                    }),
                    iconClick(
                        'Lô hàng đang trả',
                        "",
                        Icon(
                          Icons.account_balance,
                          size: 40,
                        ), () {
                      Get.to(() => DanhSachLoPage());
                    }),
                    iconClick(
                        'Thêm định mức',
                        "",
                        Icon(
                          Icons.add_circle,
                          size: 40,
                        ), () {
                      Get.toNamed("/themdinhmucltd");
                    }),
                    iconClick(
                        'Bảng định mức',
                        "",
                        Icon(
                          Icons.table_chart,
                          size: 40,
                        ), () {
                      Get.toNamed('/bangdinhmucltd');
                    }),
                    iconClick(
                        'Tạo tài khoản gia công',
                        "",
                        Icon(
                          Icons.add,
                          size: 40,
                        ), () {
                      Get.toNamed('/taouserltd');
                    }),
                    iconClick(
                        'Danh sách gia công',
                        "",
                        Icon(
                          Icons.accessibility,
                          size: 40,
                        ), () {
                      Get.toNamed('/danhsachgiacong');
                    }),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                  child: Text(
                "Danh sách đơn hàng",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('donHang')
                    .orderBy("ngayTao", descending: true)
                    .limit(6)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return SizedBox(
                    width: double.infinity,
                    height: 35.h,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        DonHang donHang = DonHang.fromJson(data);
                        String ngay =
                            DateFormat("dd-MM-yyyy").format(donHang.ngayTao);
                        return SizedBox(
                          width: 150,
                          child: InkWell(
                            onTap: () => Get.toNamed("/tinhketqualtd",
                                arguments: [donHang]),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      donHang.maDH,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              color: ColorConstants.blackColor,
                                              fontSize: 16),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  donHang.linkImg != ""
                                      ? CachedNetworkImage(
                                          imageUrl: donHang.linkImg,
                                          height: 130,
                                          width: 130,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset("assets/images/logo.jpg"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Ngày tạo : $ngay",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 11),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Column(
              //     children: [
              //       SizedBox(height: 15,),
              //       ElevatedButton(
              //           onPressed: (){
              //             Get.toNamed("/themdonhang");
              //           },
              //           child: Text("Thêm đơn hàng")
              //       ),
              //       SizedBox(height: 15,),
              //       ElevatedButton(
              //           onPressed: (){
              //             Get.toNamed("/danhsachdonhang");
              //           },
              //           child: Text("Danh sách đơn hàng")
              //       ),
              //       SizedBox(height: 15,),
              //       ElevatedButton(
              //           onPressed: (){
              //             Get.toNamed("/themdinhmuc");
              //           },
              //           child: Text("Quản lý định mức")
              //       ),
              //       SizedBox(height: 15,),
              //       ElevatedButton(
              //           onPressed: (){
              //             Get.toNamed("/bangdinhmuc");
              //           },
              //           child: Text("Bảng định mức")
              //       ),
              //       SizedBox(height: 15,),
              //       ElevatedButton(
              //           onPressed: (){
              //             Get.toNamed("/taouser");
              //           },
              //           child: Text("Tạo user")
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset(
                "assets/images/bgbedding.jpg",
                fit: BoxFit.contain,
                width: 100.w,
                height: 100.h,
              )),
          Obx(
            () => logic.currentUser.value != null
                ? Column(
                    children: <Widget>[
                      clickDrawer(
                          const Icon(
                            Icons.add_chart,
                            color: ColorPalette.primaryColor,
                          ),
                          "Thêm đơn hàng", () {
                        Get.toNamed('/themdonhangltd');
                      }),
                      clickDrawer(
                          const Icon(
                            Icons.add_circle,
                            color: ColorPalette.primaryColor,
                          ),
                          "Thêm định mức", () {
                        Get.toNamed("/themdinhmuc");
                      }),
                      clickDrawer(
                          Icon(
                            Icons.table_chart,
                            color: ColorPalette.primaryColor,
                          ),
                          "Bảng định mức", () {
                        Get.toNamed("/bangdinhmuc");
                      }),
                      clickDrawer(
                          const Icon(
                            Icons.change_circle_outlined,
                            color: ColorPalette.primaryColor,
                          ),
                          "Đổi mật khẩu", () {
                        Get.toNamed('/doimatkhau');
                      }),
                      clickDrawer(
                          Icon(
                            Icons.logout_rounded,
                            color: ColorPalette.primaryColor,
                          ),
                          "Đăng xuất", () {
                        logOut(context);
                      }),
                      clickDrawer(
                          Icon(
                            Icons.delete,
                            color: ColorPalette.primaryColor,
                          ),
                          "Xóa tài khoản", () {
                        DiaLog.showConfirmDialogYN(
                            title: "Thông báo",
                            content:
                                "Bạn có chắc muốn xóa tài khoản này không?",
                            accept: () {});
                      }),
                    ],
                  )
                : clickDrawer(
                    const Icon(
                      Icons.login,
                      color: ColorPalette.primaryColor,
                    ),
                    "Đăng nhập", () {
                    Get.offAndToNamed("/login");
                  }),
          )
        ],
      ),
    );
  }

  ListTile clickDrawer(Icon icon, String title, onpress) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: Theme.of(Get.context!).textTheme.headline5,
      ),
      onTap: () {
        onpress();
      },
    );
  }

  logOut(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Hủy", style: TextStyle(fontSize: 16)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Tiếp tục",
        style: TextStyle(fontSize: 16),
      ),
      onPressed: () {
        firebaseAuthen.signOut(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Thông báo !"),
      content: Text('Bạn có muốn đăng xuất không?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  InkWell iconClick(String title, String link, Widget image, onpress) {
    return InkWell(
      onTap: () {
        if (FirebaseAuth.instance.currentUser != null) {
          onpress();
        } else {
          Get.defaultDialog(
            title: "Thông báo",
            content: const Text('Vui lòng đăng nhập để sử dụng dịch vụ'),
          );
        }

        // Navigator.push(context, MaterialPageRoute(builder: (context)=> ListBook()));
      },
      child: SizedBox(
        height: 100,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image,
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
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

  SizedBox ImageProduct(DonHang donhang) {
    return SizedBox(
      width: 150,
      child: InkWell(
        onTap: () =>
            Get.toNamed("/chiTietSanPham", arguments: {"donhang": donhang}),
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  donhang.maDH,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .headline5!
                      .copyWith(color: ColorConstants.blackColor, fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CachedNetworkImage(
                imageUrl: donhang.linkImg,
                height: 130,
                width: 130,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 5,
              ),
              Text("data")
            ],
          ),
        ),
      ),
    );
  }
}
