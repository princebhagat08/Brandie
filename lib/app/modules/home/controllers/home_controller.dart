import 'package:brandie/app/constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/media_model.dart';
import '../../../data/model/post_model.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final PageController pageController = PageController();

  RxInt selectedBottomNav = 2.obs;

  RxInt currentPost = 0.obs;
  
  final RxMap<String, int> currentMediaByPost = <String, int>{}.obs;

  final posts = <PostModel>[].obs;

  final tabs = const [
    Tab(text: "Smart Post"),
    Tab(text: "Library"),
    Tab(text: "Communities"),
    Tab(text: "Share&Win"),
  ];

  final quickShareIcons = const [
    AppImages.insta,
    AppImages.whatsapp,
    AppImages.fb,
    AppImages.fb,
    AppImages.bussiness_whatsapp,
    AppImages.share_chat,
    AppImages.telegram,
    AppImages.tiktok,
  ];

  final navItems = const [
    AppIcons.notification,
    AppIcons.search,
    AppIcons.home,
    AppIcons.chat,
    AppIcons.profile,
  ];



  void onPostChanged(int index) {
    currentPost.value = index;
  }

  void onBottomNavChanged(int index) {
    selectedBottomNav.value = index;
  }

  void onMediaChanged({required String postId, required int index}) {
    currentMediaByPost[postId] = index;
  }

  int mediaIndexFor(String postId) {
    return currentMediaByPost[postId] ?? 0;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    posts.assignAll(dummyPosts);
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
      userImage: AppImages.profileImg,
      userName: "Emma",
      media: [
        MediaModel(
          url: AppImages.postImg1,
          type: MediaType.image,
          caption: "Soft glam look with a satin finish that lasts all day.",
          musicName: "Bad Habits",
        ),
        MediaModel(
          url: AppImages.postImg2,
          type: MediaType.image,
          caption: "Close-up swatch in daylight so the undertone reads true.",
          musicName: "Golden Hour",
        ),
        MediaModel(
          url: AppImages.postImg3,
          type: MediaType.video,
          caption: "Mini tutorial: blend, blot, then top with gloss.",
          musicName: "Rush Cut",
        ),
      ],
    ),
    PostModel(
      id: "2",
      userImage: AppImages.profileImg,
      userName: "Sophia",
      media: [
        MediaModel(
          url: AppImages.postImg2,
          type: MediaType.image,
          caption: "Summer collection moodboard with warm neutrals and gloss.",
          musicName: "Perfect",
        ),
        MediaModel(
          url: AppImages.postImg1,
          type: MediaType.video,
          caption: "Behind the scenes from the campaign shoot.",
          musicName: "Studio Loop",
        ),
        MediaModel(
          url: AppImages.postImg3,
          type: MediaType.image,
          caption: "Final hero shot for the carousel cover.",
          musicName: "Sunset Drive",
        ),
      ],
    ),
    PostModel(
      id: "3",
      userImage: AppImages.profileImg,
      userName: "Mia",
      media: [
        MediaModel(
          url: AppImages.postImg3,
          type: MediaType.image,
          caption:
              "Berry tones layered with a diffused liner for evening wear.",
          musicName: "Midnight City",
        ),
        MediaModel(
          url: AppImages.postImg2,
          type: MediaType.image,
          caption: "Packaging detail and texture shot from the new launch.",
          musicName: "Velvet Touch",
        ),
      ],
    ),
  ];
}
