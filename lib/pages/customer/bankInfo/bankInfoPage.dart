import 'dart:convert';
import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/Sevice/RealTimeDatabaseService.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/user.dart';
import 'package:tiendien_alias/pages/customer/home_screen/home/homeController.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'bankInfoController.dart';

class BankInfoPage extends StatefulWidget {
  BankInfoPage({Key? key}) : super(key: key);
  CustomerHomeViewController customerHomeViewController = Get.find();

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<BankInfoPage> {
  bool _status = true;
  BankInfoController controller = Get.put(BankInfoController());
  final FocusNode myFocusNode = FocusNode();
  final usersQuery = FirebaseDatabase.instance
      .ref()
      .child('napTien')
      .orderByChild("idTaiKhoan")
      .equalTo(FirebaseAuth.instance.currentUser!.uid);

  final oCcy = NumberFormat("#,##0", "en_US");

  UserModel? user;
  getUser() async {
    await RealTimeDatabaseService.ref
        .child('user/${FirebaseAuth.instance.currentUser!.uid}')
        .once()
        .then((value) {
      Map<String, dynamic> jsonValue =
          json.decode(json.encode(value.snapshot.value));
      user = UserModel.fromJson(jsonValue);
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Thông tin tài khoản ngân hàng',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 34),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/pngs/ic_logoBank.png"),
                      fit: BoxFit.contain,
                    )),
                  ),
                ),
                content(),
              ]),
        ),
      ),
    );
  }

  Widget content() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Thông tin ngân hàng",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              _getEditIcon()
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controller.nameCustomerController,
            decoration: const InputDecoration(
                label: Text(' Tên chủ tài khoản '),
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.normal)),
            enabled: !_status,
            autofocus: !_status,
            validator: (value) => validatorText(value!),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controller.stkCustomerController,
            decoration: const InputDecoration(
                label: Text(' Số tài khoản ngân hàng '),
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.normal)),
            enabled: !_status,
            autofocus: !_status,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) => validateNumber(value!),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controller.nameBankController,
            decoration: const InputDecoration(
                label: Text(' Tên ngân hàng '),
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.normal)),
            enabled: !_status,
            autofocus: !_status,
            validator: (value) => validatorText(value!),
          ),
          const SizedBox(
            height: 20,
          ),
          _status ? Container() : _getActionButtons(),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: const CircleAvatar(
        backgroundColor: ColorConstants.blackShade,
        radius: 18.0,
        child: Icon(
          Icons.edit,
          color: ColorConstants.whiteColor,
          size: 20.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Widget _getActionButtons() {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            if (controller.formKey.currentState!.validate()) {
              controller.updateBank();
              setState(() {
                _status = true;
              });
            }
          },
          child: Container(
            height: 45,
            decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: const Center(
                child: Text(
              'Lưu',
              style: TextStyle(
                  color: ColorConstants.whiteColor,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            setState(() {
              _status = true;
            });
          },
          child: Container(
            height: 45,
            decoration: BoxDecoration(
                border: Border.all(
                  color: ColorConstants.blackShade,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: const Center(
                child: Text(
              'Hủy',
              style: TextStyle(
                  color: ColorConstants.blackShade,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ],
    );
  }
}
