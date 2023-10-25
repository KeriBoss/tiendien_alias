import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'bannerController.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../models/banner.dart';

class BannerPage extends StatelessWidget {
  BannerPage({Key? key}) : super(key: key);

  final controller = Get.put(BannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý quảng cáo"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: itemBanner(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller
              .selectImages()
              .then((value) async => await controller.addImage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemBanner() {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listBanner.value.length,
        itemBuilder: (context, index) {
          BannerModel bannerModel = controller.listBanner[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  alignment: Alignment.topLeft,
                  imageUrl: bannerModel.linkImage,
                  width: Get.width / 1.5,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                IconButton(
                    onPressed: () => controller.removeImage(bannerModel),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
          );
        },
      );
    });
  }
}
