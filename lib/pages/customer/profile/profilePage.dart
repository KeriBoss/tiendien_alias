import 'dart:io';
import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/pages/customer/profile/profileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/textstyle_ext.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  ProfileController profileController = Get.put(ProfileController());
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                title: const Text('Thông tin tài khoản'),
                pinned: true,
                floating: false,
                forceElevated: innerBoxIsScrolled,
                elevation: 0.1),
          ];
        },
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 160.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Stack(fit: StackFit.loose, children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Obx(() => ClipOval(
                                      child: Container(
                                          width: 140.0,
                                          height: 140.0,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: profileController.file.value !=
                                                  null
                                              ? Image.file(
                                                  File(profileController
                                                      .file.value!.path),
                                                  fit: BoxFit.cover,
                                                )
                                              : profileController.currentUser
                                                              .value !=
                                                          null &&
                                                      profileController
                                                              .currentUser
                                                              .value!
                                                              .urlAvatar !=
                                                          ""
                                                  ? Image.network(
                                                      profileController
                                                          .currentUser
                                                          .value!
                                                          .urlAvatar,
                                                      fit: BoxFit.cover,
                                                      width: 140.0,
                                                      height: 140.0,
                                                    )
                                                  : const CircleAvatar(
                                                      backgroundColor:
                                                          ColorPalette
                                                              .primaryColor,
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 50,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                    ))
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 90.0, right: 100.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    _status == false
                                        ? InkWell(
                                            onTap: () {
                                              profileController.selectImages(
                                                  profileController.file);
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor:
                                                  ColorConstants.accentColor,
                                              radius: 25.0,
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  Obx(() => profileController.currentUser.value != null
                      ? Form(
                          key: profileController.formKey,
                          child: Container(
                            color: const Color(0xffFFFFFF),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 25.0, left: 25, right: 25, top: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Thông Tin',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status
                                              ? _getEditIcon()
                                              : Container(),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller:
                                        profileController.userNameController,
                                    decoration: const InputDecoration(
                                        label: Text('Tên ')),
                                    enabled: !_status,
                                    autofocus: !_status,
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    maxLines: null,
                                    controller:
                                        profileController.addressController,
                                    decoration: const InputDecoration(
                                        label: Text('Địa chỉ ')),
                                    enabled: !_status,
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller:
                                        profileController.phoneController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        label: Text('Số điện thoại ')),
                                    enabled: !_status,
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller:
                                        profileController.yearOfBirthController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        label: Text('Năm sinh ')),
                                    readOnly: true,
                                    onTap: () async {
                                      String dateString = profileController
                                          .yearOfBirthController.text
                                          .trim();

                                      DateTime dateTime =
                                          DateFormat('dd/MM/yyyy')
                                              .parse(dateString);
                                      final date = await showDatePicker(
                                          context: context,
                                          initialDate: dateTime,
                                          firstDate: DateTime(
                                              DateTime.now().year - 100),
                                          lastDate: DateTime(
                                              DateTime.now().year - 17));

                                      if (date == null) return;

                                      profileController
                                              .yearOfBirthController.text =
                                          DateFormat('dd/MM/yyyy').format(date);
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller:
                                        profileController.cccdController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        label: Text('CCCD ')),
                                    enabled: false,
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 60.h,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Mặt trước",
                                                  style: TextStyles
                                                      .defaultStyle.bold,
                                                ),
                                                Stack(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      color:
                                                          Colors.grey.shade300,
                                                      height: 25.h,
                                                      width: 100.w,
                                                      child: profileController
                                                                  .fileCCCDBefore
                                                                  .value !=
                                                              null
                                                          ? Image.file(
                                                              profileController
                                                                  .fileCCCDBefore
                                                                  .value!,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : profileController
                                                                          .currentUser
                                                                          .value !=
                                                                      null &&
                                                                  profileController
                                                                          .currentUser
                                                                          .value!
                                                                          .urlCCCDBefore !=
                                                                      ""
                                                              ? Image.network(
                                                                  profileController
                                                                      .currentUser
                                                                      .value!
                                                                      .urlCCCDBefore,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : Container(),
                                                    ),
                                                    !_status
                                                        ? Positioned(
                                                            top: 0,
                                                            right: 0,
                                                            child: profileController
                                                                        .fileCCCDBefore
                                                                        .value ==
                                                                    null
                                                                ? IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      profileController
                                                                          .selectImages(
                                                                              profileController.fileCCCDBefore);
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .camera_alt_outlined,
                                                                      size: 35,
                                                                    ),
                                                                  )
                                                                : IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      profileController
                                                                          .fileCCCDBefore
                                                                          .value = null;
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .red),
                                                                  ))
                                                        : Container()
                                                  ],
                                                )
                                              ],
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Mặt sau",
                                                  style: TextStyles
                                                      .defaultStyle.bold,
                                                ),
                                                Stack(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      color:
                                                          Colors.grey.shade300,
                                                      height: 25.h,
                                                      width: 100.w,
                                                      child: profileController
                                                                  .fileCCCDAfter
                                                                  .value !=
                                                              null
                                                          ? Image.file(
                                                              profileController
                                                                  .fileCCCDAfter
                                                                  .value!,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : profileController
                                                                          .currentUser
                                                                          .value !=
                                                                      null &&
                                                                  profileController
                                                                          .currentUser
                                                                          .value!
                                                                          .urlCCCDAfter !=
                                                                      ""
                                                              ? Image.network(
                                                                  profileController
                                                                      .currentUser
                                                                      .value!
                                                                      .urlCCCDAfter,
                                                                  fit: BoxFit
                                                                      .cover)
                                                              : Container(),
                                                    ),
                                                    !_status
                                                        ? Positioned(
                                                            top: 0,
                                                            right: 0,
                                                            child: profileController
                                                                        .fileCCCDAfter
                                                                        .value ==
                                                                    null
                                                                ? IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      profileController
                                                                          .selectImages(
                                                                              profileController.fileCCCDAfter);
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .camera_alt_outlined,
                                                                      size: 35,
                                                                    ),
                                                                  )
                                                                : IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      profileController
                                                                          .fileCCCDAfter
                                                                          .value = null;
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .red),
                                                                  ))
                                                        : Container()
                                                  ],
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Giới tính",
                                      style: TextStyles.defaultStyle.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Obx(
                                        () => ListTile(
                                          title: const Text("Nam"),
                                          leading: Radio(
                                              value: "Nam",
                                              groupValue: profileController
                                                  .gender.value,
                                              onChanged: (value) {
                                                profileController.gender.value =
                                                    "Nam";
                                              }),
                                        ),
                                      )),
                                      Expanded(
                                        child: Obx(
                                          () => ListTile(
                                            title: const Text("Nữ"),
                                            leading: Radio(
                                                value: "Nữ",
                                                groupValue: profileController
                                                    .gender.value,
                                                onChanged: (value) {
                                                  profileController
                                                      .gender.value = "Nữ";
                                                }),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  !_status ? _getActionButtons() : Container(),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container()),
                  InkWell(
                    onTap: () {
                      profileController.deleteUser();
                    },
                    child: Container(
                      height: 45,
                      margin: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 2.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstants.blackShade,
                          ),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        'Xóa tài khoản',
                        style: TextStyle(
                            color: ColorConstants.whiteColor,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              _status = true;
            });
            profileController.updateUser();
            Get.snackbar("Thông báo", "Lưu thành công",
                backgroundColor: ColorPalette.secondShadeColor,
                colorText: Colors.white);
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

  Widget _getEditIcon() {
    return GestureDetector(
      child: const CircleAvatar(
        backgroundColor: ColorConstants.blackShade,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: ColorConstants.whiteColor,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
