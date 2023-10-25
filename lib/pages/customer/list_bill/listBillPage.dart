import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_palette.dart';
import '../../../constants/textstyle_ext.dart';
import '../../../models/bill.dart';
import '../../main_controller.dart';
import 'listBillController.dart';
import 'package:intl/intl.dart';
class ListBillPage extends StatelessWidget {

  final controller = Get.put(ListBillController());
  MainController mainController = Get.put(MainController());
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,title: const Text('Danh sách hóa đơn')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('bill')
              .where('byUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .orderBy('dateBill', descending: true)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Loading"));
            }

            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                BillModel bill = BillModel.fromJson(data);
                return Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: ColorPalette.primaryColor,
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Số lượng bill: ${bill.listBill.length}",
                            style: TextStyles.defaultStyle.whiteTextColor,
                          ),
                          const SizedBox(height: 10,),
                          Text("Số tiền: ${oCcy.format(bill.priceBill)} VNĐ",
                            style: TextStyles.defaultStyle.whiteTextColor,
                          ),
                          const SizedBox(height: 10,),
                          Text("Chiết kháu: ${bill.discountBill} %",
                            style: TextStyles.defaultStyle.whiteTextColor,
                          ),
                          const SizedBox(height: 10,),
                          trangThai(bill.status),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: (){
                            mainController.showIndicadorDialog();
                            controller.deleteBill(bill.id);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget trangThai(Status status) {
    if(status == Status.choMuaBill) {
      return Text("Trạng thái: Chờ mua bill",style: TextStyles.defaultStyle.whiteTextColor,);
    }
    else if(status == Status.daMuaBill) {
      return Text("Trạng thái: Đã mua bill",style: TextStyles.defaultStyle.whiteTextColor,);
    } else {
      return Text("Trạng thái: Hoàn thành bill",style: TextStyles.defaultStyle.whiteTextColor,);

    }

  }
}