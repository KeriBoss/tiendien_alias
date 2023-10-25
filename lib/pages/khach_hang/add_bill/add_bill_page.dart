import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/khach_hang/add_bill/choose_fee/choose_fee_page.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import 'add_bill_controller.dart';

class AddBillPage extends StatelessWidget {
  var controller = Get.put(AddBillController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            AppBarWidget(hintText: 'Bán hoá đơn'),
            // Container(
            //   decoration: ColorPalette.boxDecoration,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(
            //             left: 16, top: 61, bottom: 20, right: 16),
            //         child: Row(
            //           children: [
            //             InkWell(
            //                 onTap: () {
            //                   Get.close(1);
            //                   FocusManager.instance.primaryFocus!.unfocus();
            //                 },
            //                 child: const Icon(Icons.arrow_back)),
            //             const SizedBox(width: 70,),
            //             Text('Bán hoá đơn',
            //               style: TextStyles.defaultStyle.medium.setTextSize(18),
            //             ),
            //
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xffF8F8F8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TabBar(
                controller: controller.tabController,
                labelColor: ColorPalette.blackColor,
                unselectedLabelColor: ColorPalette.greyColor,
                padding: const EdgeInsets.all(4),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorPalette.whiteColor,
                ),
                tabs: const [
                  Tab(
                    text: 'Hoá đơn',
                  ),
                  Tab(
                    text: 'Hoá đơn QR',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  buildBill(context),
                  buildBillQr(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBillQr() {
    return Container();
  }

  Widget buildBill(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(hintText: 'Chọn loại hóa đơn'),
            buildTypeBill(),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Điền mã hóa đơn của bạn vào bảng bên dưới (bạn chỉ được bán tối đa 50 hóa đơn/lần bán)",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: controller.formKey,
              child: Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: ColorPalette.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    TextFormField(
                      controller: controller.codeBillController,
                      maxLines: 50,
                      minLines: 15,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          hintText: 'Paste mã bill',
                          contentPadding: EdgeInsets.only(left: 45, top: 30)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Vui lòng không để trống ";
                        } else if (value.length > 701) {
                          return "Tối đa 50 hoá đơn";
                        }
                        return null;
                      },
                    ),
                    const Positioned(
                        top: 13,
                        left: 10,
                        child: Icon(
                          Icons.copy_rounded,
                          color: ColorPalette.greyColor,
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ButtonBlack(
                hintText: 'Bắt đầu lọc',
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    //controller.checkBillApi();
                    showBillError(context);
                  }
                  //showBillError(context);
                }),
          ],
        ),
      ),
    );
  }

  Widget buildTypeBill() {
    return Container(
      width: double.infinity,
      height: 110,
      padding: const EdgeInsets.only(left: 24, top: 24, bottom: 24),
      decoration: BoxDecoration(
        color: ColorPalette.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.listTypeBill.length,
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          String typeBill = controller.listTypeBill[index];

          return GestureDetector(
            onTap: () {
              controller.selectedItemIndex.value = index;
            },
            child: Obx(() {
              return Container(
                height: 60,
                width: 60,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: controller.selectedItemIndex.value == index
                        ? ColorPalette.greyColor
                        : ColorPalette.backGroundColor),
                padding: const EdgeInsets.all(19),
                child: Center(
                    child: Text(
                  typeBill,
                  style: TextStyles.defaultStyle.medium,
                )),
              );
            }),
          );
        },
      ),
    );
  }

  Widget titleText({required String hintText}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Text(
        hintText,
        style: TextStyles.defaultStyle.medium,
      ),
    );
  }

  void showBillError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: ColorPalette.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Lỗi hóa đơn",
                  style: TextStyles.defaultStyle.medium.setTextSize(16),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Đã xảy ra lỗi trong quá trình lọc đơn hàng",
                  style: TextStyles.defaultStyle.setTextSize(12),
                ),
                SizedBox(
                  height: 4.h,
                ),
                // controller.listBill.length > 5 ? SizedBox(
                //   height: 30.h,
                //   child: Obx(() {
                //     return ListView.builder(
                //       itemCount: controller.listBill.length,
                //       shrinkWrap: true,
                //       physics: const AlwaysScrollableScrollPhysics(),
                //       itemBuilder: (context, index) {
                //         return Container(
                //           padding: const EdgeInsets.all(12),
                //           margin: const EdgeInsets.only(bottom: 5,
                //               left: 10,
                //               right: 10),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(8),
                //               color: ColorPalette.backGroundColor
                //           ),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text("1. PC67487638746",
                //                 style: TextStyles.defaultStyle.setTextSize(
                //                     12),),
                //               Text('Mã đã thanh toán',
                //                 style: TextStyles.defaultStyle.setTextSize(12)
                //                     .setColor(ColorPalette.errorColor),)
                //             ],
                //           ),
                //         );
                //       },
                //     );
                //   }),
                // ) : Obx(() {
                //   return ListView.builder(
                //     itemCount: controller.listBill.length,
                //     shrinkWrap: true,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         padding: const EdgeInsets.all(12),
                //         margin: const EdgeInsets.only(
                //             bottom: 5, left: 10, right: 10),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: ColorPalette.backGroundColor
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text("1. PC67487638746",
                //               style: TextStyles.defaultStyle.setTextSize(12),),
                //             Text('Mã đã thanh toán',
                //               style: TextStyles.defaultStyle.setTextSize(12)
                //                   .setColor(ColorPalette.errorColor),)
                //           ],
                //         ),
                //       );
                //     },
                //   );
                // }),
                SizedBox(
                  height: 3.5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.close(1);
                      },
                      child: Container(
                        width: 20.w,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                            child: Text(
                          'Hủy',
                          style: TextStyles.defaultStyle.medium,
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addBill();
                      },
                      child: Container(
                        width: 42.w,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: ColorPalette.blackColor),
                        child: Center(
                            child: Text(
                          'Tiếp tục',
                          style: TextStyles.defaultStyle.medium.whiteTextColor,
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
