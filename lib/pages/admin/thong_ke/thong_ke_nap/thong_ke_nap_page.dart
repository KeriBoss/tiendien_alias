import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/data/dummy_data.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/widgets/appbar_widget.dart';
import 'package:tiendien_alias/widgets/buttom_black.dart';
import 'package:tiendien_alias/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'thong_ke_nap_controller.dart';

class ThongKeNapPage extends StatelessWidget {
  var controller = Get.put(ThongKeNapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(hintText: 'Thống kê nạp tiền'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Obx(() {
                return item(
                    'Tổng tiền nạp', oCcy.format(controller.totalPrice.value));
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWidget(hintText: 'Ngày bắt đầu'),
                        TextFormField(
                          controller: controller.startDateController,
                          readOnly: true,
                          onTap: () async {
                            DateTime now = DateTime.now();
                            final date = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: DateTime(now.year),
                                lastDate: now);
                            if (date == null) return;
                            String formatDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            controller.startDateController.text = formatDate;
                            controller.startDate = date;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWidget(hintText: 'Ngày kết thúc'),
                        TextFormField(
                          readOnly: true,
                          controller: controller.endDateController,
                          onTap: () async {
                            DateTime now = DateTime.now();
                            final date = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: DateTime(now.year),
                                lastDate: now);
                            if (date == null) return;
                            String formatDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            controller.endDateController.text = formatDate;
                            controller.endDate =
                                date.add(const Duration(days: 1));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: SizedBox(
                height: 51,
                child: ButtonBlack(
                    hintText: "Lọc",
                    onPressed: () {
                      if (controller.endDate == null &&
                          controller.startDate == null) return;
                      if (controller.endDate!.isAfter(controller.startDate!)) {
                        controller.sortTime();
                      } else {
                        Get.defaultDialog(
                            title: 'Thông báo',
                            content: const Text(
                                "Ngày bắt đầu phải bé hơn ngày kết thúc"));
                      }
                    }),
              ),
            ),
            listNap(),
          ],
        ),
      ),
    );
  }

  Widget listNap() {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listNapTien.length,
        itemBuilder: (context, index) {
          GiaoDichModel giaoDich = controller.listNapTien[index];
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x802196F3),
                          blurRadius: 5,
                          offset: Offset(3, 6))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CircleAvatar(
                          maxRadius: 6,
                          backgroundColor: Colors.green,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(giaoDich.time),
                          style: TextStyles.defaultStyle,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Người nạp: ${giaoDich.nameUser}",
                      style: TextStyles.defaultStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Số tiền nạp: ${oCcy.format(int.parse(giaoDich.soTien))} VNĐ",
                      style: TextStyles.defaultStyle,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget item(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: const Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$subtitle VNĐ",
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetName extends StatelessWidget {
  final String idUser;

  const GetName(this.idUser, {super.key});

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
          return const Center(child: Text(""));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            data['name'].toString(),
            style: Theme.of(context).textTheme.headlineMedium,
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
