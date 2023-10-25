import 'package:cached_network_image/cached_network_image.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullImagePage extends StatelessWidget {
  String imageUrl = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(hintText: 'Hình ảnh'),
          CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: imageUrl,
            placeholder: (context, url) => const SizedBox(
                height: 500,
                child: Center(
                  child: CircularProgressIndicator(),
                )),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
