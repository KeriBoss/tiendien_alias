import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TakeAvatarController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rxn<File> imageFile = Rxn();

  takeImage() async {
    final result = await _picker.pickImage(source: ImageSource.camera);

    if(result == null) return;

    imageFile.value = File(result.path);
  }
}