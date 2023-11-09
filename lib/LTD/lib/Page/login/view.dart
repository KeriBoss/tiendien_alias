import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Page/register/view.dart';
import 'package:tiendien_alias/LTD/lib/validate/validate.dart';

import 'logic.dart';

class LoginLTDPage extends StatelessWidget {
  final logic = Get.put(LoginLogic());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: logic.key,
          child: Container(
            decoration: BoxDecoration(
                // color: Colors.black.withOpacity(.1),
                image: const DecorationImage(
              image: AssetImage("assets/images/bg1.jpg"),
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _header(context),
                  _inputField(context),
                  _forgotPassword(context),
                  _signup(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          "Xin chào bạn!!",
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text("Nhập tài khoản và mật khẩu của bạn để đăng nhập",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }

  _inputField(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: logic.email,
            decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                )),
            validator: (value) => validatorText(value.toString()),
          ),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: logic.password,
            decoration: InputDecoration(
              hintText: "Mật khẩu",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(
                Icons.password,
                color: Colors.white,
              ),
            ),
            validator: (value) => validatorPassword(value.toString(), 6),
            obscureText: true,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (logic.key.currentState!.validate()) {
                logic.Login(context);
              }
            },
            child: Text(
              "Đăng nhập",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          )
        ],
      ),
    );
  }

  _forgotPassword(context) {
    return TextButton(
        onPressed: () {
          Get.toNamed('/quenmatkhau');
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.yellow,
        ),
        child: Text(
          "Quên mật khẩu?",
        ));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Bạn chưa có tài khoản ? ",
          style: TextStyle(fontSize: 19, color: Colors.white),
        ),
        SizedBox(
          width: 6,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterPage()));
          },
          child: Text("Đăng ký"),
          style: TextButton.styleFrom(
            foregroundColor: Colors.yellow,
          ),
        )
      ],
    );
  }
}
