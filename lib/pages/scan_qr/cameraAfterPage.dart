import 'dart:io';
import 'package:camera/camera.dart';
import 'package:tiendien_alias/constants/textstyle_ext.dart';
import 'package:tiendien_alias/pages/resgister/imageCCCD/imageCCCDPage.dart';
import 'package:tiendien_alias/pages/scan_qr/scan_qrPage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'cameraController.dart';
import 'package:get/get.dart';

class CameraAfterPage extends StatefulWidget {
  const CameraAfterPage({Key? key}) : super(key: key);

  @override
  State<CameraAfterPage> createState() => _CameraAfterPageState();
}

class _CameraAfterPageState extends State<CameraAfterPage> {
  late CameraController controller;
  CameraSelfController cameraSelfController = Get.put(CameraSelfController());

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff73B5E8),
          Color(0xffCDEEC7),
        ], transform: GradientRotation(167))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 61),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.close(1);
                      },
                      child: const Icon(Icons.arrow_back)),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Chụp CMT/CCCD Mặt sau',
                        style: TextStyles.defaultStyle.medium.setTextSize(18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                width: 100.w,
                child: FutureBuilder(
                  future: initializationCamera(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: CameraPreview(controller)),
                          ),
                          Image.asset(
                            'assets/pngs/bgCamera.png',
                            fit: BoxFit.cover,
                            width: 100.w,
                          ),
                          Positioned(
                            bottom: 10,
                            child: InkWell(
                              onTap: () => onTakePicture(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Image.asset(
                                  'assets/pngs/icCamera.png',
                                  width: 76,
                                  height: 76,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTakePicture() async {
    controller.setFlashMode(FlashMode.off);
    await controller.takePicture().then((XFile xFile) {
      if (mounted) {
        cameraSelfController.fileCCCDAfter.value = xFile;
        if (cameraSelfController.fileCCCDAfter.value != null) {
          Get.to(() => const ScanQrPage());
        }
        return;
      }
    });
  }

  Future<void> initializationCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(
      cameras[EnumCameraDescription.front.index],
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    await controller.initialize();
  }
}

enum EnumCameraDescription { front, back }
