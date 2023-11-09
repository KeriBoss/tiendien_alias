import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendien_alias/LTD/lib/Page/login/view.dart';

import 'logic.dart';

class RegisterPage extends StatelessWidget {
  final logic = Get.put(RegisterLogic());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              // color: Colors.black.withOpacity(.1),
              image: const DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputField(context),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Đăng ký",
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Nhập đầy đủ các trường để đăng ký",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }

  _inputField(context) {
    return Column(
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
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: TextStyle(color: Colors.white),
          controller: logic.phoneNumber,
          decoration: InputDecoration(
              hintText: "Số điện thoại",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              )),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: logic.address,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Địa chỉ",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(
                Icons.place,
                color: Colors.white,
              )),
        ),
        const SizedBox(height: 10),
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
          obscureText: true,
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: TextStyle(color: Colors.white),
          controller: logic.cfPassword,
          decoration: InputDecoration(
            hintText: "Nhập lại mật khẩu",
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
          obscureText: true,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            logic.SignUp(context);
          },
          child: Text(
            "Đăng Ký",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        )
      ],
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Bạn đã có tài khoản ? ",
          style: TextStyle(fontSize: 19, color: Colors.white),
        ),
        SizedBox(
          width: 6,
        ),
        TextButton(
          onPressed: () {
            Get.to(() => LoginLTDPage());
          },
          child: Text("Login"),
          style: TextButton.styleFrom(
            foregroundColor: Colors.yellow,
          ),
        )
      ],
    );
  }
}
