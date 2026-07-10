import 'package:brandie/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MediaPreviewController extends GetxController {
  final RxList<XFile> images = <XFile>[].obs;

  final captionController = TextEditingController();

  void removeImage(int index) {
    images.removeAt(index);

    if (images.isEmpty) {
      Get.back();
    }
  }

  void submitPost() {
    Get.offNamed(Routes.SMART_POST_LOADING, arguments: {'images': images});
  }

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args is List<XFile>) {
      images.assignAll(args);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    captionController.dispose();
    super.onClose();
  }
}
