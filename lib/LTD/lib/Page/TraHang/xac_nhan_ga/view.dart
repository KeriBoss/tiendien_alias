import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tiendien_alias/LTD/lib/Page/TinhKetQua/GetNameGiaCong.dart';
import 'package:tiendien_alias/LTD/lib/validate/validate.dart';

import 'logic.dart';

class XacNhanGaPage extends StatelessWidget {
  XacNhanGaPage({Key? key}) : super(key: key);

  final logic = Get.put(XacNhanGaLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Xác nhận đơn hàng"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            logic.traHang.value == null ? const Center(
              child: Text("Lỗi!! Hiện tại đơn hàng không có dữ liệu"),
            ): Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child:  logic.traHang.value!.urlImg != "" ?
                  Image.network(logic.traHang.value!.urlImg, height: 25.h, width: 100.w, fit: BoxFit.cover,)
                      : Image.asset("assets/images/logo.jpg", height: 25.h, width: 100.w, fit: BoxFit.cover,),
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Form(
                    key: logic.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(" - Tên người trả : ", style: TextStyle(color: Colors.black, fontSize: 16),),
                              GetNameKH(logic.traHang.value!.idGiaCongGa),

                            ],
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              const Text(" - Số hàng trả : ", style: TextStyle(color: Colors.black, fontSize: 16),),
                              Text(logic.traHang.value!.soGaTra.toString(), style: const TextStyle(color: Colors.black, fontSize: 16),),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            controller: logic.soGa,
                            decoration: const InputDecoration(
                              label: Text("Số hàng nhận được", style: TextStyle(color: Colors.black),)
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) => validatorText(value!),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            controller: logic.notedController,
                            decoration: const InputDecoration(
                                label: Text("Ghi chú", style: TextStyle(color: Colors.black),)
                            ),
                            maxLines: 5,
                          ),
                          const SizedBox(height: 15,),
                          ElevatedButton(
                            onPressed: (){
                              if(logic.formKey.currentState!.validate()) {
                                if(logic.tong + num.parse(logic.soGa.text) > logic.donHang.value!.dinhMuc.soBo){
                                  Get.defaultDialog(content: const Text("Số ga trả vượt quá yêu cầu!"), title: "Thông báo");
                                }else{
                                  logic.xacNhanGa();
                                }
                              }
                            },
                            child: const Text("Xác nhận", style: TextStyle(color: Colors.white),)
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}
