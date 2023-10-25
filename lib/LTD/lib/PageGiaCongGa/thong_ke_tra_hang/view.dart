import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart';
import 'package:tiendien_alias/LTD/lib/Models/TraHang.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongGa/chi_tiet_don_hang_gia_cong/logic.dart';
import 'package:tiendien_alias/LTD/lib/validate/validate.dart';

import 'logic.dart';

class ThongKeTraHangPage extends StatelessWidget {
  final logic = Get.put(ThongKeTraHangLogic());
  ChiTietDonHangGiaCongLogic giaCongLogic = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Trả hàng"),),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: logic.key,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Text(" - Ngày trả : ${DateFormat("HH:mm:ss dd-MM-yyyy").format(
                        DateTime.now())}", style: TextStyle(color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),),
                    SizedBox(height: 10,),
                    Obx(() {
                      return Row(
                        children: [
                          Text(
                            " Số ga cần trả : ${logic.donhang.value!.dinhMuc
                                .soBo}",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15,
                                fontWeight: FontWeight.normal),),
                        ],
                      );
                    }),
                    SizedBox(height: 5,),
                    Obx(() {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              " Ga đã trả nhưng chưa được xác nhận : ${logic
                                  .gaTra}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15,
                                  fontWeight: FontWeight.normal),),
                          ),
                        ],
                      );
                    }),

                    SizedBox(height: 20,),
                    TextFormField(
                      controller: logic.soGaTra,
                      validator: (value) => validatorText(value!),
                      decoration: InputDecoration(
                          label: Text("Số ga muốn trả")
                      ),
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
                        Obx(() =>
                        logic.file.value != null
                            ?
                        Expanded(child: Text(basename(logic.file.value!.path)))
                            :
                        Container(),),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        if (logic.file.value != null &&
                            logic.key.currentState!.validate()) {
                          logic.traHang();
                          Get.snackbar("Thông báo", "Trả hàng thành công",
                              backgroundColor: Colors.green);
                        } else {
                          Get.snackbar(
                              "Thông báo",
                              "Vui lòng chọn ảnh và nhập thông tin",
                              backgroundColor: Colors.red);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Trả Hàng",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(" - Danh sách trả hàng", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: logic.listTraHang.value.length,
                  itemBuilder: (context, index) {
                    TraHang traHang = logic.listTraHang.value[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: logic.donhang.value != null &&
                                  traHang.urlImg != "" ?
                              Image.network(traHang.urlImg, height: 70,
                                width: 60,
                                fit: BoxFit.cover,) : Image.asset(
                                  "assets/images/logo.jpg"),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Số ga : ${traHang.soGaTra}",
                                    style: TextStyle(color: Colors.black),),
                                  SizedBox(height: 10,),
                                  Text("${DateFormat("HH:mm:ss dd/MM/yyyy").format(traHang.ngayGiao)}",
                                    style: TextStyle(color: Colors.black),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        )
      // Form(
      //   key: logic.key,
      //   child: SizedBox(
      //     width: 100.w,
      //     child: SingleChildScrollView(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           const SizedBox(height: 30,),
      //           Obx(() => SleekCircularSlider(
      //             appearance: CircularSliderAppearance(
      //                 customColors: CustomSliderColors(
      //                     progressBarColor: ColorPalette.primaryColor),
      //                 customWidths: CustomSliderWidths(progressBarWidth: 10)),
      //             min: 0,
      //             max: logic.gaTra.value / logic.donhang.value!.dinhMuc!.soBo * 100 < 100 ? 100 : logic.gaTra.value / logic.donhang.value!.dinhMuc!.soBo * 100,
      //             initialValue: logic.gaTra.value / logic.donhang.value!.dinhMuc!.soBo * 100,
      //           ),),
      //           const SizedBox(height: 2,),
      //
      //           Text("Số ga cần trả : ${logic.donhang.value!.dinhMuc!.soBo}", style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold),),
      //           logic.gaTra.value != null ? Obx(() => Text("Số ga đã trả : ${logic.gaTra.value}", style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.normal)),
      //           ) : Container(),
      //           SizedBox(height: 10,),
      //           Divider(height: 1, color: Colors.black,),
      //           SizedBox(height: 10,),
      //
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Column(
      //               children: [
      //                 TextFormField(
      //                   decoration: InputDecoration(
      //                       labelText: "Số lượng"
      //                   ),
      //                   controller: logic.soGaTra,
      //                   validator: (value) => validatorText(
      //                       logic.soGaTra.text),
      //                 ),
      //                 Row(
      //                   children: [
      //                     IconButton(
      //                       icon: const Icon(Icons.image,
      //                           color: Colors.blue, size: 30),
      //                       onPressed: () async {
      //                         logic.selectedImage();
      //                       },
      //                     ),
      //                     Obx(() =>logic.file.value != null ?
      //                     Expanded(child: Text(basename(logic.file.value!.path))) :
      //                     Container(),
      //                     ),
      //                   ],
      //                 ),
      //                 const SizedBox(height: 20,),
      //                 ElevatedButton(
      //                   onPressed: () {
      //                     if(logic.file.value != null && logic.key.currentState!.validate()) {
      //                       logic.traHang();
      //                       Get.snackbar("Thông báo", "Trả hàng thành công", backgroundColor: Colors.green);
      //                       Get.close(2);
      //                     } else {
      //                       Get.snackbar("Thông báo", "Vui lòng chọn ảnh và nhập thông tin", backgroundColor: Colors.red);
      //                     }
      //                   },
      //                   style: ElevatedButton.styleFrom(
      //                     shape: const StadiumBorder(),
      //                     padding: const EdgeInsets.symmetric(vertical: 16),
      //                   ),
      //                   child: Text(
      //                     "Trả Hàng",
      //                     style: TextStyle(fontSize: 17, color: Colors.white),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
