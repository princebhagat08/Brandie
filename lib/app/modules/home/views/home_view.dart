import 'package:brandie/app/global_widget/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

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
              Center(child: Text("Smart Post")),
              Center(child: Text("Library")),
              Center(child: Text("Communities")),
              Center(child: Text("Share & Win")),
            ],
          ),

          
        ],
      ),
    );
  }
}
