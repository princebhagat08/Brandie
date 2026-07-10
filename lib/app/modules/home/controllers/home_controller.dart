import 'package:brandie/app/constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/media_model.dart';
import '../../../data/model/post_model.dart';
import '../../../data/model/quick_share_model.dart';
import '../../../data/model/share_payload.dart';
import '../../../global_widget/share_dialog.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/image_picker_utils.dart';
import 'share_dialog_controller.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<XFile>? pickedImages;
  RxBool isEditMode = false.obs;
  late TabController tabController;
  final PageController pageController = PageController();
  final ImagePicker _picker = ImagePicker();
  RxInt selectedBottomNav = 2.obs;

  RxInt currentPost = 0.obs;

  final RxMap<String, int> currentMediaByPost = <String, int>{}.obs;
  final RxMap<String, bool> expandedCaptionByMedia = <String, bool>{}.obs;
  final RxMap<String, bool> productVisibleByMedia = <String, bool>{}.obs;
  final Set<String> _scheduledProductReveal = <String>{};

  final posts = <PostModel>[].obs;
  final RxList<XFile> selectedImages = <XFile>[].obs;
  final tabs = const [
    Tab(text: "Smart Post"),
    Tab(text: "Library"),
    Tab(text: "Communities"),
    Tab(text: "Share&Win"),
  ];

  final quickShareItems = const [
    QuickShareItem(
      icon: AppImages.insta,
      target: QuickShareTarget.instagram,
      label: 'Instagram',
    ),
    QuickShareItem(
      icon: AppImages.whatsapp,
      target: QuickShareTarget.whatsapp,
      label: 'WhatsApp',
    ),
    QuickShareItem(
      icon: AppImages.fb,
      target: QuickShareTarget.facebook,
      label: 'Facebook',
    ),
    QuickShareItem(
      icon: AppImages.fb,
      target: QuickShareTarget.messenger,
      label: 'Messenger',
    ),
    QuickShareItem(
      icon: AppImages.bussiness_whatsapp,
      target: QuickShareTarget.businessWhatsapp,
      label: 'WhatsApp Business',
    ),
    QuickShareItem(
      icon: AppImages.share_chat,
      target: QuickShareTarget.shareChat,
      label: 'ShareChat',
    ),
    QuickShareItem(
      icon: AppImages.telegram,
      target: QuickShareTarget.telegram,
      label: 'Telegram',
    ),
    QuickShareItem(
      icon: AppImages.tiktok,
      target: QuickShareTarget.tiktok,
      label: 'TikTok',
    ),
  ];

  final navItems = const [
    AppIcons.notification,
    AppIcons.search,
    AppIcons.home,
    AppIcons.chat,
    AppIcons.profile,
  ];

  Future<void> openMediaPicker() async {
    final source = await ImagePickerUtil.showPicker(Get.context!);

    if (source == null) return;

    selectedImages.clear();

    if (source == ImageSource.camera) {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        selectedImages.add(image);
      }
    } else {
      final images = await _picker.pickMultiImage(imageQuality: 80);

      if (images.isNotEmpty) {
        selectedImages.addAll(images);
      }
    }

    if (selectedImages.isEmpty) {
      return;
    }

    Get.toNamed(Routes.MEDIA_PREVIEW, arguments: selectedImages);
  }

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

  PostModel? get currentPostModel {
    if (posts.isEmpty) return null;
    final index = currentPost.value.clamp(0, posts.length - 1);
    return posts[index];
  }

  MediaModel? currentMediaForPost(PostModel post) {
    if (post.media.isEmpty) return null;
    final index = mediaIndexFor(post.id).clamp(0, post.media.length - 1);
    return post.media[index];
  }

  String mediaStateKey({required String postId, required MediaModel media}) {
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

  Future<void> showShareDialog({
    required List<ShareDialogStep> steps,
    String? tag,
  }) async {
    final dialogTag =
        tag ?? 'share-dialog-${DateTime.now().microsecondsSinceEpoch}';

    final controller = Get.put(
      ShareDialogController(steps: steps),
      tag: dialogTag,
    );

    Get.dialog(
      ShareDialog(tag: dialogTag),
      barrierDismissible: false,
      barrierColor: Colors.grey.withValues(alpha: 0.9),
    );

    try {
      await controller.run();
    } finally {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.delete<ShareDialogController>(tag: dialogTag, force: true);
    }
  }

  Future<void> handleQuickShare(QuickShareItem item) async {
    final post = currentPostModel;
    if (post == null) return;

    final media = currentMediaForPost(post);
    if (media == null) return;

    final payload = SharePayload.from(post.userName, media);

    await showShareDialog(
      steps: [
        ShareDialogStep(
          message: 'Generating your sales link..',
          action: () async {
            await Future<void>.delayed(const Duration(seconds: 1));
          },
        ),
        ShareDialogStep(
          message: 'Copying the caption to clipboard..',
          action: () async {
            await Future<void>.delayed(const Duration(seconds: 1));
            await Clipboard.setData(ClipboardData(text: payload.fullText));
          },
        ),
        ShareDialogStep(
          message: 'Saving the content to your profile',
          action: () async {
            await Future<void>.delayed(const Duration(seconds: 1));
          },
        ),
        ShareDialogStep(
          message: 'Preparing the content for the social media',
          action: () async {
            await Future<void>.delayed(const Duration(seconds: 1));
          },
        ),
      ],
    );

    final opened = await _launchShareTarget(item.target, payload);
    if (!opened) {
      Get.snackbar(
        'Share payload copied',
        'Unable to open ${item.label}. The content was copied to clipboard.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black.withValues(alpha: 0.82),
        colorText: Colors.white,
        margin: EdgeInsets.all(16.w),
      );
    }
  }

  Future<bool> _launchShareTarget(
    QuickShareTarget target,
    SharePayload payload,
  ) async {
    final encodedText = Uri.encodeComponent(payload.fullText);
    final encodedLink = Uri.encodeComponent(normalizedLink(payload.link));
    final uris = <Uri>[];

    switch (target) {
      case QuickShareTarget.instagram:
        uris.add(Uri.parse('https://www.instagram.com/'));
        break;
      case QuickShareTarget.whatsapp:
        uris.add(Uri.parse('whatsapp://send?text=$encodedText'));
        uris.add(Uri.parse('https://wa.me/?text=$encodedText'));
        break;
      case QuickShareTarget.facebook:
        uris.add(
          Uri.parse(
            'https://www.facebook.com/sharer/sharer.php?u=$encodedLink&quote=$encodedText',
          ),
        );
        uris.add(
          Uri.parse('fb://facewebmodal/f?href=https://www.facebook.com/'),
        );
        break;
      case QuickShareTarget.messenger:
        uris.add(Uri.parse('fb-messenger://share/?link=$encodedLink'));
        uris.add(Uri.parse('https://www.messenger.com/'));
        break;
      case QuickShareTarget.businessWhatsapp:
        uris.add(Uri.parse('whatsapp://send?text=$encodedText'));
        uris.add(Uri.parse('https://wa.me/?text=$encodedText'));
        break;
      case QuickShareTarget.shareChat:
        uris.add(Uri.parse('sharechat://'));
        uris.add(Uri.parse('https://sharechat.com/'));
        break;
      case QuickShareTarget.telegram:
        uris.add(Uri.parse('tg://msg?text=$encodedText'));
        uris.add(
          Uri.parse(
            'https://t.me/share/url?url=$encodedLink&text=$encodedText',
          ),
        );
        break;
      case QuickShareTarget.tiktok:
        uris.add(Uri.parse('snssdk1233://'));
        uris.add(Uri.parse('https://www.tiktok.com/upload'));
        break;
    }

    for (final uri in uris) {
      if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        return true;
      }
    }

    return false;
  }

  String normalizedLink(String link) {
    final trimmed = link.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }
    return 'https://$trimmed';
  }

  void editCaption(int currentMediaIndex) async {
    final editedPost = await Get.toNamed(
      Routes.EDIT_POST,
      arguments: {"post": currentPostModel, "mediaIndex": currentMediaIndex},
    );

    if (editedPost != null) {
      print("---> REFRESHED");
      posts.refresh();
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

  void addDummyPostFromSelectedImages(List<XFile> images) {
    if (images.isEmpty || dummyPosts.isEmpty) return;
    isEditMode.value = true;
    final firstPost = dummyPosts.first;

    final media = images
        .map(
          (image) => MediaModel(
            url: image.path,
            type: MediaType.xfile,
            caption: firstPost.media.first.caption,
            music: firstPost.media.first.music,
            hashtag: firstPost.media.first.hashtag,
            referralCode: firstPost.media.first.referralCode,
            link: firstPost.media.first.link,
          ),
        )
        .toList();

    final newPost = PostModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userImage: firstPost.userImage,
      userName: firstPost.userName,
      media: media,
    );

    posts.clear();
    posts.assign(newPost);
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
