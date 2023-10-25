import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/khach_hang/add_bill/add_bill_page.dart';
import 'package:tiendien_alias/pages/khach_hang/market/detail_bill/detail_bill_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'market_controller.dart';

class MarketPage extends StatelessWidget {
  var controller = Get.put(MarketController());
  final oCcy = NumberFormat("#,##0", 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 20),
              width: 100.w,
              decoration: const BoxDecoration(
                  color: ColorPalette.blackColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoUser(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm theo ứng dụng thanh toán',
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 24,
                    color: Color(0xff62C196),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle:
                      TextStyles.defaultStyle.setColor(const Color(0xffB1B1B1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                ),
                onChanged: (value) {
                  controller.searchView(value);
                },
              ),
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
                  buildListBill(),
                  const Column(
                    children: [],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListBill() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            headerTable(),
            Obx(() {
              return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.listBill.length,
                  itemBuilder: (context, index) {
                    BillModel bill = controller.listBill[index];
                    return itemTable(bill);
                  });
            }),
          ],
        ),
      ),
    );
  }

  Widget itemTable(BillModel bill) {
    num width = 100.w - 32;
    return Container(
      color: ColorPalette.backGroundColor,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: width * 0.2,
                height: 40,
                color: ColorPalette.whiteColor,
                child: Center(
                  child: formatName(bill.username, bill.gender),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Container(
                width: width * 0.19,
                height: 40,
                color: ColorPalette.whiteColor,
                child: Center(
                  child: Text(
                    '${bill.listBill.length}',
                    style: TextStyles.defaultStyle.setTextSize(12),
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Container(
                width: width * 0.2,
                height: 40,
                color: ColorPalette.whiteColor,
                child: Center(
                  child: Text(
                    "${bill.discountBill}",
                    style: TextStyles.defaultStyle.setTextSize(12),
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Container(
                width: width * 0.19,
                height: 40,
                color: ColorPalette.whiteColor,
                child: Center(
                  child: Text(
                    controller.formatMoney(bill.totalBill),
                    style: TextStyles.defaultStyle.setTextSize(12),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => DetailBillPage(), arguments: bill);
                },
                child: Container(
                  width: width * 0.2,
                  height: 40,
                  color: ColorPalette.whiteColor,
                  child: Center(
                    child: Text(
                      "Chi tiết",
                      style: TextStyles.defaultStyle.medium
                          .setTextSize(12)
                          .setColor(const Color(0xff91CD91))
                          .copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget headerTable() {
    num width = 100.w - 32;

    return Row(
      children: [
        Container(
          width: width * 0.2,
          height: 40,
          decoration: const BoxDecoration(
              color: Color(0xffB1B1B1),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8))),
          child: Center(
            child: Text(
              "Đại lý",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.19,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "SL",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.2,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "Phí GD",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.19,
          height: 40,
          color: const Color(0xffB1B1B1),
          child: Center(
            child: Text(
              "Tổng",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width * 0.2,
          height: 40,
          decoration: const BoxDecoration(
              color: Color(0xffB1B1B1),
              borderRadius: BorderRadius.only(topRight: Radius.circular(8))),
          child: Center(
            child: Text(
              "Trạng thái",
              style: TextStyles.defaultStyle.setTextSize(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInfoUser() {
    return Row(
      children: [
        controller.homeCustomerController.currentUser.value!.urlAvatar == ""
            ? Image.asset(
                'assets/png/avatar.png',
                width: 40,
                height: 40,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  controller
                      .homeCustomerController.currentUser.value!.urlAvatar,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/png/avatar.png',
                      width: 40,
                      height: 40,
                    );
                  },
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Text(
                      controller.homeCustomerController.currentUser.value!.name,
                      style: TextStyles.defaultStyle.medium
                          .setTextSize(16)
                          .whiteTextColor,
                    );
                  }),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(() {
                    return cardMoney(controller
                        .homeCustomerController.currentUser.value!.money);
                  }),
                ],
              ),
              InkWell(
                onTap: () {
                  Get.to(() => AddBillPage());
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: ColorPalette.whiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Image.asset(
                    "assets/png/ic_shopping.png",
                    width: 22,
                    height: 22,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget cardMoney(num money) {
    return Container(
      padding: const EdgeInsets.only(left: 6, right: 10, top: 4, bottom: 4),
      decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Image.asset(
            'assets/png/ic_money.png',
            width: 14,
            height: 14,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            "${oCcy.format(money)} Point",
            style: TextStyles.defaultStyle.setTextSize(12),
          )
        ],
      ),
    );
  }

  Widget formatName(String username, String gender) {
    List<String> nameParts = username.split(" ");
    String firstName = gender == 'Nam' ? 'Mr' : 'Mrs';
    String lastName = nameParts.last.length <= 5
        ? '$firstName ${nameParts.last}'
        : '$firstName ${nameParts.last.substring(0, 3)}...';

    return Text(
      lastName,
      style: TextStyles.defaultStyle.setTextSize(12),
    );
  }
}

class GetNameCustomer extends StatelessWidget {
  final String idCustomer;

  const GetNameCustomer(this.idCustomer, {super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(idCustomer).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          UserModel userModel = UserModel.fromJson(data);
          List<String> nameParts = userModel.name.split(" ");
          String lastName = nameParts.last.length <= 5
              ? 'Mr ${nameParts.last}'
              : 'Mr ${nameParts.last.substring(0, 3)}...';
          return Text(
            lastName,
            style: TextStyles.defaultStyle.setTextSize(12),
          );
        }

        return const Text("Loading");
      },
    );
  }
}
