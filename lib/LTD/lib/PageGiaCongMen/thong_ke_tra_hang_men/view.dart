import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongMen/chi_tiet_don_hang_gia_cong/logic.dart';
import 'package:tiendien_alias/LTD/lib/constants/color_palette.dart';
import 'package:tiendien_alias/LTD/lib/validate/validate.dart';

import 'logic.dart';

class ThongKeTraHangMenPage extends StatelessWidget {
  final logic = Get.put(ThongKeTraHangMenLogic());
  ChiTietDonHangGiaCongMenLogic giaCongMenLogic = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thống kê trả hàng"),
      ),
      body: Form(
        key: logic.key,
        child: SizedBox(
          width: 100.w,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Obx(
                  () => SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                        customColors: CustomSliderColors(
                            progressBarColor: ColorPalette.primaryColor),
                        customWidths: CustomSliderWidths(progressBarWidth: 10)),
                    min: 0,
                    max: logic.menTra.value /
                                logic.donhang.value!.dinhMuc!.soBo *
                                100 <
                            100
                        ? 100
                        : logic.menTra.value /
                            logic.donhang.value!.dinhMuc!.soBo *
                            100,
                    initialValue: logic.menTra.value /
                        logic.donhang.value!.dinhMuc!.soBo *
                        100,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Số mền cần trả : ${logic.donhang.value!.dinhMuc!.soBo}",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                logic.menTra.value != null
                    ? Obx(
                        () => Text("Số mền đã trả : ${logic.menTra.value}",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.normal)),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: "Số lượng"),
                        controller: logic.soLuong,
                        validator: (value) => validatorText(logic.soLuong.text),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.image,
                                color: Colors.blue, size: 30),
                            onPressed: () async {
                              logic.selectedImage();
                            },
                          ),
                          Obx(
                            () => logic.file.value != null
                                ? Expanded(
                                    child:
                                        Text(basename(logic.file.value!.path)))
                                : Container(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (logic.file.value != null &&
                              logic.key.currentState!.validate()) {
                            logic.traHang();
                            Get.snackbar("Thông báo", "Trả hàng thành công",
                                backgroundColor: Colors.green);
                            Get.close(2);
                          } else {
                            Get.snackbar("Thông báo",
                                "Vui lòng chọn ảnh và nhập thông tin",
                                backgroundColor: Colors.red);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          "Trả Hàng",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
