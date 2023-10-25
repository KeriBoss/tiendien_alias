import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constants/color_constants.dart';
import '../../../validator/validatorString.dart';
import 'rutTienController.dart';

class RutTienPage extends GetView<RutTienController> {
  @override
  var controller = Get.put(RutTienController());
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Rút tiền')),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      Obx(() {
                        return Text(
                          "Số tiền hiện tại: ${oCcy.format(controller.currentUser.value!.money)}",
                          style: TextStyles.defaultStyle.medium.setTextSize(16),
                        );
                      }),
                      Image.asset(
                        "assets/pngs/25498.jpg",
                        height: 50,
                      )
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 4) {
                        return "Vui lòng nhập ít nhất 1,000 VNĐ";
                      } else {
                        return null;
                      }
                    },
                    controller: controller.xuController,
                    decoration: InputDecoration(
                        label: const Text('Số tiền muốn rút'),
                        hintText: "Vui lòng nhập số tiền",
                        suffixIcon: Image.asset(
                          "assets/pngs/25498.jpg",
                          height: 50,
                        )),
                  ),
                  const SizedBox(height: 20.0),
                  Obx(() => controller.price.value != 0
                      ? Row(
                          children: [
                            const Text(
                              'Tổng tiền',
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(width: 15.0),
                            Text(
                              oCcy.format(controller.price.value),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              ' đ',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        )
                      : Container()),
                  const SizedBox(height: 15.0),
                  ElevatedButton(
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          controller.updatePrice();
                          await controller.rutTien();
                        }
                      },
                      child: const Text(
                        'Rút xu',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
