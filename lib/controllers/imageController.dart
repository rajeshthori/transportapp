import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageController extends GetxController {
  RxList<File> selectedImages = <File>[].obs;

  final ImagePicker _picker = ImagePicker();

  // Pick multiple images from gallery
  Future<void> pickImages() async {
    try {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null) {
        for (var pickedFile in pickedFiles) {
          selectedImages.add(File(pickedFile.path));
        }
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  // Pick image from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        selectedImages.add(File(pickedFile.path));
      }
    } catch (e) {
      print("Error picking image from camera: $e");
    }
  }

  // Remove image
  void removeImage(File image) {
    selectedImages.remove(image);
  }
}
