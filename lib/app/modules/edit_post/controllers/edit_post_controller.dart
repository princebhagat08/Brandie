import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/model/post_model.dart';
import '../../home/controllers/home_controller.dart';

class EditPostController extends GetxController {
  late final PostModel post;

  late final TextEditingController captionController;
  late final TextEditingController hashtagController;
  late final TextEditingController codeController;
  late final TextEditingController linkController;

  final isChanged = false.obs;

  @override
  void onInit() {
    super.onInit();

    post = Get.arguments['post'] as PostModel;
    int mediaIndex = Get.arguments['mediaIndex'] as int;

    final media = post.media[mediaIndex];

    captionController = TextEditingController(text: media.caption);

    hashtagController = TextEditingController(text: media.hashtag);

    codeController = TextEditingController(text: media.referralCode);

    linkController = TextEditingController(text: media.link);

    captionController.addListener(_checkChanges);
    hashtagController.addListener(_checkChanges);
    codeController.addListener(_checkChanges);
    linkController.addListener(_checkChanges);
  }

  void _checkChanges() {
    final media = post.media.first;

    isChanged.value =
        captionController.text != media.caption ||
        hashtagController.text != media.hashtag ||
        codeController.text != media.referralCode ||
        linkController.text != media.link;
  }

  void save() {
    Get.focusScope?.unfocus();

    final media = post.media.first;
    
    media.caption = captionController.text;
    media.hashtag = hashtagController.text;
    media.referralCode = codeController.text;
    media.link = linkController.text;
    Get.find<HomeController>().posts.refresh();
    Get.back(result: post);
  }

  @override
  void onClose() {
    captionController.dispose();
    hashtagController.dispose();
    codeController.dispose();
    linkController.dispose();
    super.onClose();
  }
}
