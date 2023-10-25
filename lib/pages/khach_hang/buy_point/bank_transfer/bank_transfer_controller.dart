import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendien_alias/models/bankCustomer.dart';
import 'package:tiendien_alias/models/giaoDich.dart';
import 'package:tiendien_alias/models/notification.dart';
import 'package:tiendien_alias/models/userModel.dart';
import 'package:tiendien_alias/pages/DiaLog/diaLog.dart';
import 'package:tiendien_alias/pages/khach_hang/buy_point/buy_point_controller.dart';
import 'package:tiendien_alias/pages/khach_hang/buy_point/buy_point_success/buy_point_success_page.dart';
import 'package:tiendien_alias/provider/databaseProvider.dart';
import 'package:tiendien_alias/provider/userModelProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class BankTransferController extends GetxController {
  BuyPointController buyPointController = Get.find();
  num money = Get.arguments;
  RxString imagePath = "".obs;
  DatabaseProvider databaseProvider = DatabaseProvider();
  Timer? timer;
  RxInt seconds = RxInt(59);
  Rxn<BankCustomer> bankAdmin = Rxn();

  void pickerImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      imagePath.value = pickedImage.path;
    } catch (e) {
      print(e.toString());
    }
  }

  int randomNumber() {
    Random random = Random();
    // Generate a random number within the specified range
    int firstPart = random.nextInt(900000) + 100000;
    int secondPart = random.nextInt(900000) + 100000;
    // Concatenate the two parts to create a 12-digit number
    int random12DigitNumber = int.parse('$firstPart$secondPart');

    return random12DigitNumber;
  }

  handleBankTransfer() async {
    UserModel? currentUser = await UserModelProvider().getCurrentUser();
    final docNapTien = FirebaseFirestore.instance.collection('napTien').doc();

    String urlImage = "";
    if (imagePath.value != "") {
      String nameImage = basename(imagePath.value);
      final path = 'ChuyenKhoan/${docNapTien.id}/$nameImage';
      final fileImage = File(imagePath.value);
      var ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(fileImage);
      urlImage = (await ref.getDownloadURL()).toString();
    }

    DateTime now = DateTime.now();

    String code = randomNumber().toString();

    NotificationModel notification = NotificationModel(
        id: code,
        title: 'Giao dịch thành công',
        body: 'Bạn đã mua thành công',
        price: money,
        data: '',
        isView: false,
        byUser: FirebaseAuth.instance.currentUser!.uid,
        typeNotification: TypeNotification.buyPoints,
        typePrice: TypePrice.point,
        status: 'Chờ xử lý',
        sourceMoney: 'Ví Phoenix Pay',
        createdDate: now);
    await databaseProvider.addModel(
        collection: 'notification',
        id: notification.id,
        toJsonModel: notification.toJson());

    GiaoDichModel napTienModel = GiaoDichModel(
        docNapTien.id,
        code,
        currentUser!.id,
        currentUser.name,
        '',
        now,
        "",
        money.toString(),
        LoaiGiaoDich.napTien,
        "Chờ xử lý",
        urlImage);

    await docNapTien.set(napTienModel.toJson()).whenComplete(() {
      timer!.cancel();
      imagePath.value = "";
      buyPointController.moneyController.clear();
      Get.off(() => BuyPointSuccessPage(), arguments: [money, currentUser]);
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getBankAdmin();
  }

  getBankAdmin() async {
    await FirebaseFirestore.instance
        .collection('adminBank')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        bankAdmin.value = BankCustomer.fromJson(value.docs.first.data());
      } else {
        bankAdmin.value = BankCustomer(
            id: 'id',
            idCustomer: 'idCustomer',
            nameCustomer: 'Phoenix bank',
            stkBank: 'Phoenix Bank Account',
            nameBank: '03656687778765',
            logoBank: 'logoBank');
      }
    });
  }
}
