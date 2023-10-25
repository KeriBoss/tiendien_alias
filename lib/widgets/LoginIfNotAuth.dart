import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginIfNotAuth extends StatelessWidget {
  const LoginIfNotAuth({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 1.2,
      height: 150,
      decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Hãy khám phá những dịch vụ với ưu đã hấp dẫn ngay hôm nay!',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => Get.toNamed("/login"),
              child: const Text(
                'Đăng nhập / Đăng ký',
                style: TextStyle(color: ColorConstants.primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
