import 'package:brandie/app/constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/media_model.dart';
import '../../../data/model/post_model.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final PageController pageController = PageController();

  RxInt selectedBottomNav = 2.obs;

  RxInt currentPost = 0.obs;
  
  final RxMap<String, int> currentMediaByPost = <String, int>{}.obs;
  final RxMap<String, bool> expandedCaptionByMedia = <String, bool>{}.obs;
  final RxMap<String, bool> productVisibleByMedia = <String, bool>{}.obs;
  final Set<String> _scheduledProductReveal = <String>{};

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

  String mediaStateKey({
    required String postId,
    required MediaModel media,
  }) {
    return '$postId|${media.url}|${media.link}';
  }

  bool isCaptionExpanded(String mediaKey) {
    return expandedCaptionByMedia[mediaKey] ?? false;
  }

  void toggleCaptionExpanded(String mediaKey) {
    expandedCaptionByMedia[mediaKey] = !isCaptionExpanded(mediaKey);
  }

  bool isProductVisible(String mediaKey) {
    return productVisibleByMedia[mediaKey] ?? false;
  }

  void scheduleProductReveal(String mediaKey) {
    if (productVisibleByMedia[mediaKey] == true ||
        _scheduledProductReveal.contains(mediaKey)) {
      return;
    }

    _scheduledProductReveal.add(mediaKey);
    Future.delayed(const Duration(seconds: 3), () {
      productVisibleByMedia[mediaKey] = true;
      _scheduledProductReveal.remove(mediaKey);
    });
  }

  
  Future<void> openProductLink(String rawLink) async {
    final parsedUri = Uri.tryParse(rawLink);
    final uri = parsedUri != null && parsedUri.hasScheme
        ? parsedUri
        : Uri.parse('https://$rawLink');

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        'Unable to open link',
        rawLink,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black.withValues(alpha: 0.82),
        colorText: Colors.white,
      );
    }
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
          caption:
              "Soft glam look with a satin finish that lasts all day. Rich pigment, comfortable wear, and a soft-focus finish built for short-form beauty content.",
          music: "Bad Habits",
          hashtag: "#Oriflame #GiordaniGold #LipCareGoals",
          referralCode: "UK-AMANDA3012",
          link: "www.oriflame.com/giordani/amanda3012",
        ),
        MediaModel(
          url: AppImages.postImg2,
          type: MediaType.image,
          caption:
              "Close-up swatch in daylight so the undertone reads true and the finish stays honest without extra filtering.",
          music: "Golden Hour",
          hashtag: "#GlowCheck #DaylightSwatch #BeautyEdit",
          referralCode: "UK-EMMA2204",
          link: "www.oriflame.com/swatches/emma2204",
        ),
        MediaModel(
          url: AppImages.postImg3,
          type: MediaType.video,
          caption:
              "Mini tutorial: blend, blot, then top with gloss for a fuller finish that still feels lightweight on the lips.",
          music: "Rush Cut",
          hashtag: "#LipTutorial #GlossLayer #CreatorTips",
          referralCode: "UK-REEL9901",
          link: "www.oriflame.com/tutorials/reel9901",
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
          caption:
              "Summer collection moodboard with warm neutrals, gloss, and a lightweight complexion story for everyday wear.",
          music: "Perfect",
          hashtag: "#SummerCollection #WarmNeutrals #BeautyMood",
          referralCode: "UK-SOPHIA4402",
          link: "www.oriflame.com/summer/sophia4402",
        ),
        MediaModel(
          url: AppImages.postImg1,
          type: MediaType.video,
          caption:
              "Behind the scenes from the campaign shoot with close product moments and lighting changes across the set.",
          music: "Studio Loop",
          hashtag: "#BTSBeauty #CampaignShoot #StudioDiary",
          referralCode: "UK-STUDIO7840",
          link: "www.oriflame.com/studio/studio7840",
        ),
        MediaModel(
          url: AppImages.postImg3,
          type: MediaType.image,
          caption:
              "Final hero shot for the carousel cover with a sharper contrast pass and a more dramatic crop for the first frame.",
          music: "Sunset Drive",
          hashtag: "#HeroFrame #CarouselCover #BeautyLaunch",
          referralCode: "UK-HERO7711",
          link: "www.oriflame.com/launch/hero7711",
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
              "Berry tones layered with a diffused liner for evening wear, designed to hold shape while still reading soft on camera.",
          music: "Midnight City",
          hashtag: "#BerryLook #EveningGlam #SoftLiner",
          referralCode: "UK-MIA6720",
          link: "www.oriflame.com/evening/mia6720",
        ),
        MediaModel(
          url: AppImages.postImg2,
          type: MediaType.image,
          caption:
              "Packaging detail and texture shot from the new launch, focused on finish, branding, and shelf appeal.",
          music: "Velvet Touch",
          hashtag: "#PackagingDetail #TextureShot #NewLaunch",
          referralCode: "UK-DETAIL1148",
          link: "www.oriflame.com/details/detail1148",
        ),
      ],
    ),
  ];
}
