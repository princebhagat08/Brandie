import 'package:brandie/app/global_widget/custom_appbar.dart';
import 'package:brandie/app/modules/home/views/smart_post/smart_post.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/quick_share_section.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(controller: controller.tabController),
      body: Stack(
        children: [
          TabBarView(
            controller: controller.tabController,
            children: const [
              SmartPost(),
              Center(child: Text("Library")),
              Center(child: Text("Communities")),
              Center(child: Text("Share & Win")),
            ],
          ),

          /// Quick Share
          const QuickShareSection(),

          /// Bottom Navigation
          const HomeBottomBar(),
        ],
      ),
    );
  }
}
