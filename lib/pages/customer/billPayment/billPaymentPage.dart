import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/textstyle_ext.dart';
import '../../../models/userModel.dart';
import 'billPaymentController.dart';
class BillPaymentPage extends StatelessWidget {

  final controller = Get.put(BillPaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chợ bills điện')),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 2).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                UserModel user = UserModel.fromJson(data);
                return Container(
                  height: 60,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(2,4),
                      )],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data['name'], style: TextStyles.defaultStyle.setTextSize(19),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('bill')
                                .where('byUser', isEqualTo: data['id']).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Text("Loading");
                              }

                              return Text("${snapshot.data!.docs.length.toString()} Hóa đơn",
                                style: TextStyles.defaultStyle,
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                              onPressed: (){
                                //Get.to(() => ListBillByUserPage(user: user), arguments: user);
                              },
                              child: Text("Chi tiết")
                          ),
                        ],
                      )
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
}