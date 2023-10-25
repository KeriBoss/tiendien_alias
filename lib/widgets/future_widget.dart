import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/constants/font_constants.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/dichVu.dart';
import 'package:tiendien_alias/models/dichVuSub.dart';
import 'package:tiendien_alias/pages/customer/home_screen/home/homeController.dart';
import 'package:tiendien_alias/pages/customer/home_screen/home_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FavoriteWidget extends StatefulWidget {
  FavoriteWidget({Key? key, this.dichVu}) : super(key: key);
  DichVu? dichVu;
  @override
  _FutureWidgetState createState() => _FutureWidgetState(dichVu!);
}

class _FutureWidgetState extends State<FavoriteWidget> {
  CustomerHomeViewController homeController = Get.find();
  DichVu dichVu;

  _FutureWidgetState(this.dichVu) {
    Loadata();
    FirebaseDatabase.instance
        .ref()
        .child("favorite")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .onValue
        .listen((event) {
      Loadata();
      setState(() {});
    });
  }
  Loadata() {
    getUrl = FirebaseDatabase.instance
        .ref()
        .child("favorite")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(dichVu.id)
        .get();
  }

  late Future<DataSnapshot> getUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataSnapshot>(
        future: getUrl,
        builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.value == null) {
              return InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  //homeController.setFavorite(dichVu);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.favorite_border,
                    color: Color.fromARGB(255, 238, 198, 68),
                  ),
                ),
              );
            }
          }
          return InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(32.0),
            ),
            onTap: () {
              //homeController.removeFavorite(dichVu);
              Get.appUpdate();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 238, 198, 68),
                size: 30,
              ),
            ),
          );
        });
  }
}

class NameUserWidget extends StatelessWidget {
  final id;

  NameUserWidget(this.id) {
    getUrl = FirebaseFirestore.instance.collection('users').doc(id).get();
  }

  late Future<DocumentSnapshot> getUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: getUrl,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(
              data['name'],
              style: TextStyles.defaultStyle,
            );
          }

          return const Text("loading");
        });
  }
}

class DichVuWidget extends StatelessWidget {
  final id;

  DichVuWidget(this.id) {
    getUrl = FirebaseDatabase.instance.ref().child("dichVuSub/$id").get();
  }

  late Future<DataSnapshot> getUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataSnapshot>(
        future: getUrl,
        builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.data == null) {
            return Text("");
          }

          DichVuSub dichVu = DichVuSub.fromJson(
              json.decode(json.encode(snapshot.data!.value)));
          return Button(dichVu);
        });
  }
}

Widget Button(DichVuSub dichVuSub) {
  return Container(
    margin: EdgeInsets.all(3),
    child: SizedBox(
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: ColorConstants.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side:
              const BorderSide(width: 1.0, color: ColorConstants.primaryColor),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dichVuSub!.ten,
              style: TextStyle(
                fontFamily: FontConstants.comfortaaLight,
                color: ColorConstants.blackShade,
                fontSize: 9.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        )),
      ),
    ),
  );
}
