import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/models/bill.dart';
import 'package:tiendien_alias/pages/customer/addBill/addBillPage.dart';
import 'package:tiendien_alias/pages/customer/addBillQR/addBillQRPage.dart';
import 'package:tiendien_alias/pages/customer/chiTietBill/chiTietBillPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'householdPaymentController.dart';
import 'package:intl/intl.dart';

class HouseholdPaymentPage extends StatelessWidget {
  final controller = Get.put(HouseholdPaymentController());
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán hộ'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.dialog(AlertDialog(
                      title: Center(
                        child: Text(
                          "Chọn phương thức up bills",
                          style: TextStyles.defaultStyle.setTextSize(18),
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Get.close(1);
                                Get.to(() => AddBillPage());
                              },
                              child: const Text("Hóa đơn điện")),
                          // const SizedBox(height: 10),
                          // ElevatedButton(
                          //     onPressed: (){
                          //       Get.close(1);
                          //       Get.to(() => AddBillQRPage());
                          //     },
                          //     child: const Text("Mã QR code")
                          // ),
                        ],
                      ),
                    ));
                  },
                  child: Container(
                      width: 100.w,
                      height: 10.h,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: Center(
                          child: Text(
                        "Bạn có hóa đơn cần được thanh toán hộ hưởng chiết khấu ?",
                        style: TextStyles.defaultStyle
                            .setColor(ColorPalette.secondShadeColor),
                        textAlign: TextAlign.center,
                      ))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('bill')
                        .where('status', isEqualTo: Status.choMuaBill.name)
                        .orderBy('priceBill',
                            descending: controller.isSort.value)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Row(
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Loading...",
                                style: TextStyles.defaultStyle,
                              ),
                            ],
                          ),
                        );
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                            child: Text(
                          "Hiện thị không có bills nào",
                          style: TextStyles.defaultStyle.setTextSize(20),
                        ));
                      }

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          border: TableBorder.all(
                              width: 2,
                              color: Colors.grey.shade700,
                              borderRadius: BorderRadius.circular(8)),
                          columns: [
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                "STT",
                                style: TextStyles.defaultStyle.setTextSize(13),
                                textAlign: TextAlign.center,
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                "Người \nup",
                                style: TextStyles.defaultStyle.setTextSize(13),
                                textAlign: TextAlign.center,
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                "CK",
                                style: TextStyles.defaultStyle.setTextSize(13),
                                textAlign: TextAlign.center,
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                "SL",
                                style: TextStyles.defaultStyle.setTextSize(13),
                                textAlign: TextAlign.center,
                              ),
                            )),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  "Tổng \ntiền",
                                  style:
                                      TextStyles.defaultStyle.setTextSize(13),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  "Chi \ntiết",
                                  style:
                                      TextStyles.defaultStyle.setTextSize(13),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                          rows: buildList(snapshot.data!.docs),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DataRow> buildList(List<DocumentSnapshot> snapshot) {
    int index = 0;
    return snapshot.map((item) {
      index++;
      return buildListItem(item, index);
    }).toList();
  }

  DataRow buildListItem(DocumentSnapshot documentSnapshot, int index) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    BillModel bill = BillModel.fromJson(data);

    String chietKhau = (bill.discountBill + 0.22).toStringAsFixed(2);
    double priceBill = bill.priceBill - (bill.priceBill * 0.22 / 100);
    return DataRow(cells: [
      DataCell(Center(
          child: Text(
        "$index",
        style: TextStyles.defaultStyle.setTextSize(13),
      ))),
      DataCell(Center(child: GetUserName(bill.byUser))),
      DataCell(Center(
          child: Text(
        "$chietKhau%",
        style: TextStyles.defaultStyle.setTextSize(13),
      ))),
      DataCell(Center(
          child: Text(
        "${bill.listBill.length}",
        style: TextStyles.defaultStyle.setTextSize(13),
      ))),
      DataCell(Center(
          child: Text(
        oCcy.format(bill.totalBill),
        style: TextStyles.defaultStyle.setTextSize(13),
      ))),
      DataCell(GestureDetector(
        onTap: () {
          Get.to(() => ListBillByUserPage(
                bill: bill,
              ));
        },
        child: const Icon(Icons.arrow_forward),
      )),
    ]);
  }
}

class GetUserName extends StatelessWidget {
  final String idUser;

  const GetUserName(this.idUser, {super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(idUser).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Center(child: Text("Document does not exist"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            data['name'].toString().toCapitalize(),
            style: TextStyles.defaultStyle.setTextSize(13),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
