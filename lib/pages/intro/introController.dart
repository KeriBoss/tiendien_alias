import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  final PageController pageController = PageController();
  RxInt indexPage = RxInt(0);
  @override
  void onInit() {
    // TODO: implement onInit
    pageController.addListener(() {
      indexPage.value = pageController.page!.toInt();
    });
    super.onInit();
  }
}