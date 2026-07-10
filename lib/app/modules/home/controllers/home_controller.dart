import 'package:brandie/app/constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/media_model.dart';
import '../../../data/model/post_model.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final PageController pageController = PageController();
  RxInt currentPost = 0.obs;

  RxInt currentMedia = 0.obs;

  final posts = <PostModel>[].obs;

  final tabs = const [
    Tab(text: "Smart Post"),
    Tab(text: "Library"),
    Tab(text: "Communities"),
    Tab(text: "Share&Win"),
  ];

  void onPostChanged(int index) {
    currentPost.value = index;

    currentMedia.value = 0;
  }

  void onMediaChanged(int index) {
    currentMedia.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);

    //  posts.addAll(dummyPosts);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  final dummyPosts = [
    PostModel(
      id: "1",

      userImage: "profile.png",

      userName: "Emma",

      caption: "This lipstick is amazing...",

      musicName: "Bad Habits",

      media: [
        MediaModel(url: AppImages.postImg1, type: MediaType.image),

        MediaModel(url: AppImages.postImg2, type: MediaType.image),

        MediaModel(url: AppImages.postImg3, type: MediaType.video),
      ],
    ),

    PostModel(
      id: "2",

      userImage: "profile2.png",

      userName: "Sophia",

      caption: "Summer Collection",

      musicName: "Perfect",

      media: [
        MediaModel(url: "assets/4.jpg", type: MediaType.image),

        MediaModel(url: "assets/5.jpg", type: MediaType.image),
      ],
    ),
  ];
}
