import 'package:flutter/material.dart';
import 'package:tiendien_alias/LTD/lib/Models/Users.dart';

class NhanvienGiaCong extends StatelessWidget {
  const NhanvienGiaCong({Key? key, required this.userModel}) : super(key: key);
  final UserModelLTD userModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: Colors.grey.withOpacity(.2),
          width: 1,
        ),
      ),
      elevation: 0.0,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 400,
        color: Color.fromRGBO(244, 243, 243, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 60.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      'https://banner2.cleanpng.com/20180613/uz/kisspng-clerk-computer-icons-clip-art-clerk-5b20ba415e19a0.6115672115288714893854.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Tên Nhân viên',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      userModel.username,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Số điện thoại : ${userModel.phone}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              'Địa chỉ : ${userModel.address}',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
