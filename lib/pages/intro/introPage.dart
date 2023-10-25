import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'introController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatelessWidget {
  final controller = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            children: [
              buildItemIntroPage(
                  "assets/pngs/undraw_Deliveries_2r4y.png",
                  "Tiết kiệm thời gian",
                  "Với đội ngũ chuyên nghiệp sẽ có kế hoạch đảm bảo thời gian thực hiện vận chuyển nhanh chóng đúng tiến độ.",
                  Alignment.center),
              buildItemIntroPage(
                  "assets/pngs/undraw_delivery_truck_vt6p.png",
                  "Tiết kiệm chi phí",
                  "Chi phí dịch vụ chuyển nhà trọn gói sẽ rẻ hơn nhiều so với tự vận chuyển và bạn không cần phải lo lắng về chi phí phát sinh.",
                  Alignment.center),
              buildItemIntroPage(
                  "assets/pngs/undraw_jewelry_iima.png",
                  "Tiết kiệm công sức",
                  "Tiết kiệm thời gian\nVới đội ngũ chuyên nghiệp sẽ có kế hoạch đảm bảo thời gian thực hiện vận chuyển nhanh chóng đúng tiến độ.",
                  Alignment.center),
            ],
          ),
          Positioned(
              left: 24,
              right: 24,
              bottom: 72,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SmoothPageIndicator(
                      controller: controller.pageController,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        dotWidth: 7,
                        dotHeight: 5,
                        activeDotColor: Colors.orange,
                      ),
                    ),
                  ),
                  Obx(() => Expanded(
                      flex: 4,
                      child: buttonWidget(
                          title: controller.indexPage.value != 2
                              ? "Tiếp theo"
                              : "Bắt đầu ",
                          onTap: () {
                            if (controller.indexPage.value != 2) {
                              controller.pageController.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            } else {
                              Get.toNamed('/customer_home');
                            }
                          }))),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildItemIntroPage(String image, String title, String description,
      AlignmentGeometry alignment) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: alignment,
            child: Image.asset(
              image,
              height: 400,
              fit: BoxFit.fitHeight,
            )),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    height: 16 / 14),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                description,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    height: 16 / 14),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buttonWidget({required String title, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [
                ColorConstants.primaryColor,
                Color(0xff6155CC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            )),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              height: 16 / 14),
        ),
      ),
    );
  }
}
