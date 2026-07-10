import 'package:brandie/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/model/progress_model.dart';
import '../../../routes/app_pages.dart';

class SmartPostLoadingController extends GetxController {
  List<XFile> images = <XFile>[].obs;
  RxBool isAllCompleted = false.obs;
  final progressList = <ProgressModel>[
    ProgressModel('Preparing popular content for you'),
    ProgressModel('Crafting a caption to boost engagement'),
    ProgressModel('Adding your personal referral link and code'),
    ProgressModel('Finding trending songs on other social media'),
  ];

  @override
  void onInit() {
    super.onInit();
    startLoading();

    images = (Get.arguments?['images'] as List<XFile>?) ?? [];
  }

  Future<void> startLoading() async {

    for (final item in progressList) {

      item.isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      item.isLoading.value = false;
      item.isCompleted.value = true;
    }

    isAllCompleted.value = true;

    if(Get.isRegistered<HomeController>()){
      final homeController = Get.find<HomeController>();
      homeController.addDummyPostFromSelectedImages(images);
    }

    await Future.delayed(const Duration(seconds: 1));
    Get.offNamed(Routes.HOME,arguments: {'images':images});
   
  }
}