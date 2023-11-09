import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Models/Users.dart';
import 'package:tiendien_alias/LTD/lib/Page/home/view.dart';
import 'package:tiendien_alias/LTD/lib/Page/login/view.dart';
import 'package:tiendien_alias/LTD/lib/PageGiaCongGa/home_gia_cong/view.dart';
import 'package:tiendien_alias/LTD/lib/Provider.dart';

class SplashPageLTD extends StatefulWidget {
  const SplashPageLTD({Key? key}) : super(key: key);

  @override
  State<SplashPageLTD> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPageLTD> {
  Rxn<UserModelLTD> currentUser = Rxn();
  UserProvider userProvider = UserProvider();
  @override
  void initState() {
    redirectIntroPage();
    super.initState();
  }

  void redirectIntroPage() async {
    //final ignoreIntroPage = LocalStorageService.getValue('ignoreIntroPage') as bool?;
    await Future.delayed(const Duration(seconds: 2));
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance
          .collection("usersltd")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (value.exists) {
          if (value['role'] == 1) {
            Get.close(1);
            Get.to(HomePage());
          }
          if (value['role'] == 2) {
            Get.close(1);
            Get.to(() => HomeGiaCongPage());
            //Get.toNamed("/homegiacongltd");
          }
        } else {
          Get.to(LoginLTDPage());
        }
        // if(value['role']==3){
        //   Get.close(1);
        //
        //   Get.toNamed("/homegiacongmen");
        // }
        // if(value['role']==4){
        //   Get.close(1);
        //   Get.toNamed("/homegiacongfull");
        // }
      });
    } else {
      Get.to(LoginLTDPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff000000),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                width: Get.width,
                height: Get.width,
                child: Image.asset("assets/images/logo.jpg"),
              ),
              SizedBox(
                height: 10,
              ),
              CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
