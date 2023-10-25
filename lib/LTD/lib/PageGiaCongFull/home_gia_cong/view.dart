import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tiendien_alias/LTD/lib/Firebase/Firebase_Auth.dart';
import 'package:tiendien_alias/LTD/lib/Models/DonHang.dart';
import 'package:tiendien_alias/LTD/lib/constants/color_constants.dart';

import 'logic.dart';
enum SampleItem { itemdangxuat }
class HomeGiaCongFullPage extends StatefulWidget {
  const HomeGiaCongFullPage({Key? key}) : super(key: key);

  @override
  State<HomeGiaCongFullPage> createState() => _HomeGiaCongFullPageState();
}

class _HomeGiaCongFullPageState extends State<HomeGiaCongFullPage> {
  SampleItem? selectedMenu;
  final logic = Get.put(HomeGiaCongFullLogic());
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
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          actions: [PopupMenuButton<SampleItem>(
            initialValue: selectedMenu,
            // Callback that sets the selected popup menu item.
            onSelected: (SampleItem item) {
              setState(() {
                selectedMenu = item;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemdangxuat,
                child: Text('Đăng xuất'),
                onTap: () {
                  FirebaseAuthen().signOut(context);
                },
              ),

            ],
          ),],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){

          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.home),
        ),
        body : Column(
          children: [
            Container(
              height: 30.h,
              width: 100.w,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.1),
                  image: const DecorationImage(image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.cover,
                  )
              ),
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
                        final urlImage =
                        logic.listImage[index];
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
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: (){
                    Get.toNamed("/dachsachdonhanggiacongfull");
                  },
                  child: Text("Danh sách đơn cần gia công",style: TextStyle(color: Colors.white),)
              ),
            ),
            SizedBox(height: 10,),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('donHang').where("idGiaCongFull",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .limit(6)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return SizedBox(
                  width: double.infinity,
                  height: 35.h,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      DonHang donHang = DonHang.fromJson(data);
                      String ngay = DateFormat("dd-MM-yyyy").format(donHang.ngayTao);
                      return SizedBox(
                        width: 150,
                        child: InkWell(
                          onTap: () =>
                              Get.toNamed("/chitietdonhanggiacongfull", arguments: [donHang]),
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
                                        .copyWith(color:
                                    ColorConstants.blackColor, fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                donHang.linkImg != "" ?CachedNetworkImage(
                                  imageUrl: donHang.linkImg,
                                  height: 130,
                                  width: 130,
                                  fit: BoxFit.cover,
                                ): Image.asset("assets/images/logo.jpg"),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Ngày tạo : $ngay", style: const TextStyle(color: Colors.black, fontSize: 11),)
                              ],
                            )
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
