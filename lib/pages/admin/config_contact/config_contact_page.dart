import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config_contact_controller.dart';

class ConfigContactPage extends StatelessWidget {
  var controller = Get.put(ConfigContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(hintText: 'Cấu hình liên hệ'),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/png/ic_zalo.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Zalo",
                      style: TextStyles.defaultStyle.setTextSize(16).medium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Form(
                  key: controller.formKeyZalo,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.zaloController,
                          decoration: const InputDecoration(
                              hintText: 'Số điện thoại zalo'),
                          validator: (value) => validatorPhoneNumber(value!),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.formKeyZalo.currentState!.validate()) {
                            controller.updateZalo();
                          }
                        },
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/png/ic_message.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Messenger (Messenger Id)",
                      style: TextStyles.defaultStyle.setTextSize(16).medium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Form(
                  key: controller.formKeyMessenger,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.messengerController,
                          decoration:
                              const InputDecoration(hintText: 'Id messenger'),
                          validator: (value) => validatorText(value!),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.formKeyMessenger.currentState!
                              .validate()) {
                            controller.updateMessenger();
                          }
                        },
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/png/ic_phone_green.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Hotline 1",
                      style: TextStyles.defaultStyle.setTextSize(16).medium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Form(
                  key: controller.formKeyHotline1,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.hotline1Controller,
                          decoration: const InputDecoration(hintText: 'Phone'),
                          validator: (value) => validatorPhoneNumber(value!),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.formKeyHotline1.currentState!
                              .validate()) {
                            controller.updatePhone1();
                          }
                        },
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/png/ic_phone_green.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Hotline 2",
                      style: TextStyles.defaultStyle.setTextSize(16).medium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Form(
                  key: controller.formKeyHotline2,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.hotline2Controller,
                          decoration: const InputDecoration(hintText: 'Phone'),
                          validator: (value) => validatorPhoneNumber(value!),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.formKeyHotline2.currentState!
                              .validate()) {
                            controller.updatePhone2();
                          }
                        },
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/png/ic_phone_green.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Hotline 3",
                      style: TextStyles.defaultStyle.setTextSize(16).medium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Form(
                  key: controller.formKeyHotline3,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.hotline3Controller,
                          decoration: const InputDecoration(hintText: 'Phone'),
                          validator: (value) => validatorPhoneNumber(value!),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.formKeyHotline3.currentState!
                              .validate()) {
                            controller.updatePhone3();
                          }
                        },
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
