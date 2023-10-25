import 'package:flutter/material.dart';
import '../../../models/giaoDich.dart';
import '../../../widgets/nameUser_widget.dart';
import 'thongKeController.dart';
import 'thongKePage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShowAllGiaoDichRut extends StatelessWidget {
  ShowAllGiaoDichRut({Key? key}) : super(key: key);

  final controller = Get.put(ThongKeController());
  final oCcy = NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử rút tiền"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          return listRut();
        }),
      ),
    );
  }

  Widget listRut() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.listGiaoDichRut.length,
      itemBuilder: (context, index) {
        GiaoDichModel giaoDich = controller.listGiaoDichRut[index];
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserNameWidget(giaoDich.idUser),
                      Text(giaoDich.time.toString(),
                          style: Theme.of(context).textTheme.headlineMedium)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Số tiền nạp: ${oCcy.format(int.parse(giaoDich.soTien))} VNĐ",
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
