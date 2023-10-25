import 'dart:io';

import 'package:tiendien_alias/pages/resgister/checkInfomation/checkInfomationPage.dart';
import 'package:tiendien_alias/pages/resgister/imageCCCD/imageCCCDPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({Key? key}) : super(key: key);

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                  borderRadius: 8, borderColor: Colors.redAccent),
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text('Data: ${result!.code}')
                  : const Text('Quét mã qr CMT/CCCD'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      int count = countOccurrences(result!.code!, "|");

      if (result != null && count == 6) {
        controller.pauseCamera();
        Get.to(() => ImageCCCDPage(), arguments: result!.code);
      }
    });
  }

  int countOccurrences(String mainString, String subString) {
    int count = 0;
    int startIndex = 0;

    while (startIndex < mainString.length) {
      int index = mainString.indexOf(subString, startIndex);
      if (index != -1) {
        count++;
        startIndex = index + subString.length;
      } else {
        break;
      }
    }

    return count;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
