import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:flutter/services.dart';
import 'commission_level_controller.dart';
import 'package:tiendien_alias/pages/khach_hang/add_bill/order_sell/order_sell_page.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CommissionLevelPage extends StatelessWidget {
  var controller = Get.put(CommissionLevelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backGroundColor,
      body: Column(
        children: [
          AppBarWidget(hintText: 'Chọn mức hoa hồng'),
          // Container(
          //   decoration: ColorPalette.boxDecoration,
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //         left: 16, top: 61, bottom: 20, right: 16),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         InkWell(
          //             onTap: () {
          //               Get.close(1);
          //               FocusManager.instance.primaryFocus!.unfocus();
          //             },
          //             child: const Icon(Icons.arrow_back)),
          //         //const SizedBox(width: 70,),
          //         Text('Chọn mức hoa hồng',
          //           style: TextStyles.defaultStyle.medium.setTextSize(18),
          //         ),
          //         const Text(" "),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 9.h,
          ),
          Text(
            "Chọn mức hoa hồng",
            style: TextStyles.defaultStyle.medium.setTextSize(18),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            "Vui lòng chọn mức phí mong muốn",
            style: TextStyles.defaultStyle.setTextSize(12),
          ),
          SizedBox(
            height: 6.h,
          ),
          inputFee(),
          SizedBox(
            height: 6.h,
          ),
          Text(
            "Mức hoa hồng tối đa: 2%",
            style: TextStyles.defaultStyle
                .setTextSize(12)
                .setColor(const Color(0xff949494)),
          ),
          SizedBox(
            height: 11.h,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   child: Row(
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           Get.close(1);
          //         },
          //         child: Container(
          //           width: 30.w,
          //           padding: const EdgeInsets.symmetric(vertical: 15),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(26),
          //             color: ColorPalette.whiteColor,
          //             border: Border.all()
          //           ),
          //           child: Center(child: Text("Hủy", style: TextStyles.defaultStyle.medium,)),
          //         ),
          //       ),
          //       const SizedBox(width: 12,),
          //       Expanded(child: ButtonBlack(
          //           hintText: 'Xác nhận',
          //           onPressed: (){
          //             controller.savePercent();
          //             //Get.to(() => OrderSellPage());
          //           })
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 6.h,
        //padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 24),

        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.close(1);
              },
              child: Container(
                width: 30.w,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: ColorPalette.whiteColor,
                    border: Border.all()),
                child: Center(
                    child: Text(
                  "Hủy",
                  style: TextStyles.defaultStyle.setTextSize(16).medium,
                )),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: ButtonBlack(
                    hintText: 'Xác nhận',
                    onPressed: () {
                      controller.savePercent();
                    })),
          ],
        ),
      ),
    );
  }

  Widget inputFee() {
    return Form(
      key: controller.formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 55,
            child: TextFormField(
              autofocus: true,
              controller: controller.percent1,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 1,
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle,
              decoration: const InputDecoration(
                counterText: "",
                hintText: '0',
                hintStyle: TextStyles.defaultStyle,
              ),
              onSaved: (newValue) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusManager.instance.primaryFocus!.nextFocus();
                }
              },
            ),
          ),
          Text(
            " , ",
            style: TextStyles.defaultStyle.medium.setTextSize(25),
          ),
          SizedBox(
            width: 55,
            child: TextFormField(
              autofocus: true,
              controller: controller.percent2,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 1,
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle,
              decoration: const InputDecoration(
                counterText: "",
                hintText: '0',
                hintStyle: TextStyles.defaultStyle,
              ),
              onSaved: (newValue) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusManager.instance.primaryFocus!.nextFocus();
                }
              },
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          SizedBox(
            width: 55,
            child: TextFormField(
              autofocus: true,
              controller: controller.percent3,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 1,
              decoration: const InputDecoration(
                counterText: "",
                hintText: '0',
                hintStyle: TextStyles.defaultStyle,
              ),
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle,
              onSaved: (newValue) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusManager.instance.primaryFocus!.nextFocus();
                }
              },
            ),
          ),
          Text(
            " %",
            style: TextStyles.defaultStyle.medium.setTextSize(20),
          )
        ],
      ),
    );
  }
}
