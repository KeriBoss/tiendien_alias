import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'contact_controller.dart';

class ContactPage extends StatelessWidget {
  var controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBarWidget(hintText: 'Liên hệ'),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mạng xã hội",
                style: TextStyles.defaultStyle.medium,
              ),
              SizedBox(
                height: 4.7.h,
              ),
              InkWell(
                onTap: () {
                  controller.openZalo();
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/png/ic_zalo.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Phoenix Zalo",
                      style: TextStyles.defaultStyle.setTextSize(16).medium,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 4.6.h,
              ),
              InkWell(
                onTap: () {
                  controller.openMessage();
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/png/ic_message.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Phoenix Messenger",
                      style: TextStyles.defaultStyle.setTextSize(16).medium,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 9.8.h,
              ),
              Text(
                "Hottline",
                style: TextStyles.defaultStyle.medium,
              ),
              SizedBox(
                height: 4.6.h,
              ),
              InkWell(
                onTap: () {
                  controller.openPhone1();
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/png/ic_phone_green.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Obx(() {
                      return Text(
                        controller.phone1.value,
                        style: TextStyles.defaultStyle.setTextSize(16).medium,
                      );
                    })
                  ],
                ),
              ),
              Obx(() {
                return controller.phone2.value.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 4.6.h,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/png/ic_phone_green.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                controller.phone2.value,
                                style: TextStyles.defaultStyle
                                    .setTextSize(16)
                                    .medium,
                              )
                            ],
                          ),
                        ],
                      )
                    : Container();
              }),
              Obx(() {
                return controller.phone3.value.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 4.6.h,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/png/ic_phone_green.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                controller.phone3.value,
                                style: TextStyles.defaultStyle
                                    .setTextSize(16)
                                    .medium,
                              )
                            ],
                          ),
                        ],
                      )
                    : Container();
              }),
            ],
          ),
        )
      ],
    ));
  }
}
