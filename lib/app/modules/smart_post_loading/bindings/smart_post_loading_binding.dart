import 'package:get/get.dart';

import '../controllers/smart_post_loading_controller.dart';

class SmartPostLoadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SmartPostLoadingController>(
      () => SmartPostLoadingController(),
    );
  }
}
