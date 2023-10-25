
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String kinhdoanh = 'Phòng kinh doanh';
  String ketoan = 'Phòng kế toán';
  String qlk = 'Quản lý kho';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Container(
          // height: 100.h,
          // width: 100.w,
          // decoration: BoxDecoration(
          //     color: Colors.black.withOpacity(.1),
          //     image: DecorationImage(image: AssetImage("assets/images/background.jpg"),
          //       fit: BoxFit.cover,
          //     )
          // ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

              ],
            ),
          ),
        )
    );
  }
}
