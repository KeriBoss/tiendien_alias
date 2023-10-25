import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'logic.dart';

class ChiTietTraHangPage extends StatelessWidget {
  final logic = Get.put(ChiTietTraHangLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Chi tiết đơn hàng"),),
        body: Container(
          height: 100.h,
          width: 100.w,
          decoration: const BoxDecoration(
            // color: Colors.black.withOpacity(.1),
              image: DecorationImage(image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 30.h,
                width: 100.w,
                child: Image.asset("assets/images/bg1.jpg", width: 100.w, height: 30.h, fit: BoxFit.cover,),
              ),
              SizedBox(height: 15),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("- Mã hàng : AHF3564", style: TextStyle(color: Colors.white,
                        fontSize: 24, fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 10,),
                    Text("- Tổng số mét : 67.1M", style: TextStyle(color: Colors.white,
                        fontSize: 19, fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 10,),
                    Text("- Số bộ : 10 bộ", style: TextStyle(color: Colors.white,
                        fontSize: 19, fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 10,),
                    Text("- Ga : 25.1", style: TextStyle(color: Colors.white,
                        fontSize: 19, fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 10,),
                    Text("- Mền : 42", style: TextStyle(color: Colors.white,
                        fontSize: 19, fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 10,),
                    Text("- Nam : 0", style: TextStyle(color: Colors.white,
                        fontSize: 19, fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 10,),
                    Text("- Hàng lẻ : 0", style: TextStyle(color: Colors.white,
                        fontSize: 19, fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ),
              SizedBox( height: 20,),
              Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        child: Text(
                          "Giao cho gia công",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Tính",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
