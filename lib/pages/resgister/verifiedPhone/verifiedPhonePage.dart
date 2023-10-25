import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/resgister/verifiedCCCD/verifiedCCCDPage.dart';
import 'package:tiendien_alias/validator/validatorString.dart';
import 'package:tiendien_alias/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import 'verifiedPhoneController.dart';

class VerifiedPhonePage extends StatelessWidget {
  var controller = Get.put(VerifiedPhoneController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff73B5E8),
            Color(0xffCDEEC7),
          ], transform: GradientRotation(167))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 61),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.close(1);
                        },
                        child: const Icon(Icons.arrow_back)),
                    const SizedBox(
                      width: 70,
                    ),
                    Text(
                      'Xác thực OTP',
                      style: TextStyles.defaultStyle.medium.setTextSize(18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: 100.w,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13),
                      )),
                  child: Form(
                    //key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 75,
                        ),
                        Text(
                          "Nhập mã OTP",
                          style: TextStyles.defaultStyle.setTextSize(20),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Nhập mã OTP đã được gửi đến số điện thoại",
                          style: TextStyles.defaultStyle.setTextSize(13),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          '*** **** ${controller.phone.substring(7, 10)}',
                          style: TextStyles.defaultStyle.setTextSize(13),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildPinput(),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(() {
                          return controller.timeStart.value != 0
                              ? Text(
                                  'Gửi lại mã sau (${controller.timeStart.value}s)',
                                  style: TextStyles.defaultStyle
                                      .setTextSize(13)
                                      .setColor(const Color(0xffB8B8B8)),
                                )
                              : InkWell(
                                  onTap: () => controller.sendAgain(),
                                  child: Text(
                                    'Gửi lại mã',
                                    style: TextStyles.defaultStyle
                                        .setTextSize(13)
                                        .setColor(ColorPalette.primaryColor),
                                  ),
                                );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Pinput buildPinput() {
    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyDecorationWith(
        border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
        borderRadius: BorderRadius.circular(8),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: const Color.fromRGBO(234, 239, 243, 1),
        ),
      ),
      length: 6,
      onCompleted: (pin) => controller.verifyOTP(pin),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 60,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xffD9D9D9)),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
