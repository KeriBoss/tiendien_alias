import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/customer/chiaSe/chiaSeController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChiaSePage extends StatelessWidget {
  ChiaSeController controller = Get.put(ChiaSeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: 100.w,
                height: 100.h / 3.5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    ColorPalette.primaryColor,
                    ColorPalette.secondShadeColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () => Get.back(),
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )),
                                Text(
                                  "Giới thiệu",
                                  style: TextStyles
                                      .defaultStyle.whiteTextColor.bold
                                      .setTextSize(25),
                                )
                              ],
                            ),
                            Text(
                              "Giúp bạn bè quanh bạn \nbiết đến và cùng trải \nnghiệm cùng nhau!",
                              style: TextStyles
                                  .defaultStyle.whiteTextColor.regular,
                            )
                          ],
                        ),
                        Image.asset(
                          "assets/pngs/share_Link.png",
                          height: 14.h,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 10.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Chia sẽ mã giới thiệu",
                                style: TextStyles.defaultStyle.semiBold
                                    .setTextSize(17),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                FirebaseAuth.instance.currentUser!.uid,
                                style: TextStyles.defaultStyle
                                    .setColor(Colors.blueAccent)
                                    .setTextSize(14),
                              )
                            ],
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                              onPressed: () async {
                                Fluttertoast.showToast(
                                    msg: "Sao chép thành công",
                                    backgroundColor:
                                        ColorPalette.secondShadeColor,
                                    fontSize: 16);
                                await Clipboard.setData(ClipboardData(
                                    text: FirebaseAuth
                                        .instance.currentUser!.uid));
                              },
                              icon: const Icon(Icons.copy))
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Bạn nhận được lời mời từ bạn bè?",
                      style: TextStyles.defaultStyle.semiBold
                          .setTextSize(18)
                          .setColor(Colors.black),
                    ),
                    SizedBox(height: 2.h),
                    TextFormField(
                      controller: controller.codeController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          hintText: "Nhập mã giới thiệu của họ ở đây"),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        controller.inputCodeFromFriend();
                      },
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "Cách thức hoạt động",
                      style: TextStyles.defaultStyle.semiBold
                          .setTextSize(18)
                          .setColor(Colors.black),
                    ),
                    SizedBox(height: 2.h),
                    numberAndText("1",
                        "Chia sẽ mã giới thiệu và mời bạn bè tham gia cùng."),
                    SizedBox(height: 1.5.h),
                    numberAndText("2",
                        "Bạn bè của bạn tải, đăng ký và nhập mã giới thiệu"),
                    SizedBox(height: 1.5.h),
                    numberAndText(
                        "3", "Bạn và họ sẽ được nhận thưởng từ ứng dụng"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget numberAndText(String number, String tittle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.grey.shade300),
          child: Text(
            number,
            style: TextStyles.defaultStyle.bold,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            tittle,
            style: TextStyles.defaultStyle,
          ),
        )
      ],
    );
  }
}
