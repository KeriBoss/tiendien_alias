import 'dart:io';

import 'package:tiendien_alias/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sizer/sizer.dart';
import 'addBillQRController.dart';

class QRPage extends StatefulWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controllerQR;
  Barcode? result;
  var addBillController = Get.put(AddBillQRController());

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      controllerQR!.pauseCamera();
    } else if (Platform.isIOS) {
      controllerQR!.resumeCamera();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controllerQR!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                cutOutSize: 80.w,
                borderWidth: 10,
                borderLength: 25,
                borderRadius: 12,
                borderColor: ColorPalette.primaryColor),
          ),
          Positioned(bottom: 10, child: buildResult()),
          Positioned(top: 20, right: 10, child: buildFlash()),
        ],
      ),
    );
  }

  Widget buildFlash() => IconButton(
      onPressed: () async {
        await controllerQR!.toggleFlash();
        setState(() {});
      },
      icon: FutureBuilder<bool?>(
        future: controllerQR?.getFlashStatus(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Icon(
              snapshot.data! ? Icons.flash_on : Icons.flash_off,
              color: Colors.grey,
            );
          } else {
            return Container();
          }
        },
      ));

  Widget buildResult() => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(12)),
        child: Text(
          result != null ? "Kết quả scan: ${result!.code}" : "Quét mã code!",
          maxLines: 4,
        ),
      );

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      controllerQR = controller;
    });
    controllerQR!.scannedDataStream.listen((event) {
      setState(() {
        result = event;
        print(result!.code);
      });
    });
  }
}
