import 'package:tiendien_alias/constants/color_constants.dart';

import 'package:tiendien_alias/validator/validatorString.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'napTienController.dart';

class NapTienPage extends GetView<NapTienController> {
  final oCcy = NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Nạp tiền')),
          body: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 4) {
                          return "Vui lòng nhập ít nhất 1,000 VNĐ";
                        } else {
                          return null;
                        }
                      },
                      controller: controller.priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: const Text('Số tiền muốn nạp'),
                          hintText: "Vui lòng nhập số tiền",
                          suffixIcon: Image.asset(
                            "assets/pngs/25498.jpg",
                            height: 50,
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Obx(() => controller.price != 0
                        ? Row(
                            children: [
                              const Text(
                                'Tổng tiền',
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                oCcy.format(controller.price.value),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Text(
                                ' đ',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          )
                        : Container()),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            controller.updatePrice();
                            await controller.thucHienNapTien();
                          }
                        },
                        child: const Text(
                          'Nạp tiền',
                          style: TextStyle(color: ColorConstants.whiteColor),
                        )),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
