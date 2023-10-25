import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Firebase/SMS.dart';

class HomeGiaCongMenLogic extends GetxController {
  RxInt currentIndex = 0.obs;
  MessegingService messegingService = MessegingService();
  List<String> listImage = ["http://www.collectrenaissance.com/"
      "images/products/lrg/renaissance-birds-eye-stripe-"
      "bedding-set-RHR-101-BE-BE_lrg.jpg",
    "https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?"
        "ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGJlZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"

  ];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    messegingService.requestPermission();
    messegingService.loadFCM();
    messegingService.listenFCM();
  }
}
