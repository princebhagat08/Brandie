import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../controllers/home_controller.dart';
import 'widgets/post_item.dart';

class SmartPost extends GetView<HomeController> {
  const SmartPost({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      scrollDirection: Axis.vertical,
      itemCount: controller.posts.length,

      onPageChanged: controller.onPostChanged,

      itemBuilder: (_, index) {
        return PostItem(postId: controller.posts[index].id);
      },
    );
  }
}
