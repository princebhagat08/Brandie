import 'package:brandie/app/global_widget/custom_appbar.dart';
import 'package:brandie/app/modules/home/views/smart_post/smart_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/theme/theme_extension.dart';
import '../controllers/home_controller.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/quick_share_section.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onCameraTap: controller.openMediaPicker,
        bottom: TabBar(
          controller: controller.tabController,
          isScrollable: false,
          indicatorColor: Colors.transparent,
          labelColor: AppColor.primaryColor,
          labelStyle: context.text.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: context.text.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
          unselectedLabelColor: Get.isDarkMode? Colors.white: AppColor.blackColor,
          tabs: const [
            Tab(text: "Smart Post"),
            Tab(text: "Library"),
            Tab(text: "Communities"),
            Tab(text: "Share&Win"),
          ],
        ),
      ),
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
