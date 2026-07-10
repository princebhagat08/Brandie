import 'dart:io';

import 'package:brandie/app/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../../data/model/media_model.dart';
import '../../../../../data/model/post_model.dart';
import '../../../controllers/home_controller.dart';
import 'post_background.dart';

class PostItem extends StatelessWidget {
  final PostModel post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final currentMediaIndex = controller.mediaIndexFor(post.id);
      final media = post.media[currentMediaIndex];
      final mediaKey = controller.mediaStateKey(postId: post.id, media: media);

      return Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            itemCount: post.media.length,
            onPageChanged: (index) {
              controller.onMediaChanged(postId: post.id, index: index);
            },
            itemBuilder: (_, index) {
              return PostBackground(media: post.media[index]);
            },
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 130.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PostHeader(
                    post: post,
                    media: media,
                    currentMediaIndex: currentMediaIndex,
                  ),
                  const Spacer(),
                  _ProductSection(media: media, mediaKey: mediaKey),
                  SizedBox(height: 6.h),
                  _PostMeta(post: post, media: media, mediaKey: mediaKey,currentMediaIndex: currentMediaIndex,),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _PostHeader extends StatelessWidget {
  final PostModel post;
  final MediaModel media;
  final int currentMediaIndex;

  const _PostHeader({
    required this.post,
    required this.media,
    required this.currentMediaIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 26.r, backgroundImage: AssetImage(post.userImage)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "High-converting in Oriflame Community",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (post.media.length > 1)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(80),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              '${currentMediaIndex + 1} of ${post.media.length}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
      ],
    );
  }
}

class _PostMeta extends GetView<HomeController> {
  final PostModel post;
  final MediaModel media;
  final String mediaKey;
  final int currentMediaIndex;
  const _PostMeta({
    required this.post,
    required this.media,
    required this.mediaKey,
    required this.currentMediaIndex
  });

  @override
  Widget build(BuildContext context) {
    final captionWithTagline = '${media.caption}\n${media.hashtag}';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.music_note_rounded,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    children: [
                      const TextSpan(text: 'Recommended: '),
                      TextSpan(
                        text: media.music,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Caption
        SizedBox(height: 3.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => ReadMoreText(
                  captionWithTagline,
                  trimMode: TrimMode.Line,
                  trimLines: controller.isCaptionExpanded(mediaKey) ? 100 : 2,
                  trimCollapsedText: " See More",
                  trimExpandedText: " See Less",
                  delimiter: "...",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  moreStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                  lessStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              Text(
                "Use my referral code: ${media.referralCode}",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),

              Text(
                "Use my referral link: ${media.link}",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),

             if(controller.isEditMode.value) GestureDetector(
              onTap: ()=>controller.editCaption(currentMediaIndex),
               child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 3.w,
                  children: [
                    Icon(Icons.edit, color: AppColor.whiteColor, size: 20.sp),
                    Text(
                      "Edit Caption",
                      style: TextStyle(color: AppColor.whiteColor,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
             ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductSection extends GetView<HomeController> {
  final MediaModel media;
  final String mediaKey;

  const _ProductSection({required this.media, required this.mediaKey});

  @override
  Widget build(BuildContext context) {
    controller.scheduleProductReveal(mediaKey);

    return Obx(() {
      final isVisible = controller.isProductVisible(mediaKey);

      return AnimatedSlide(
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOutCubic,
        offset: isVisible ? Offset.zero : const Offset(0, 0.18),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 550),
          curve: Curves.easeOut,
          opacity: isVisible ? 1 : 0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                await controller.openProductLink(media.link.trim());
              },
              borderRadius: BorderRadius.circular(16.r),
              child: Ink(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.40),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: media.type == MediaType.xfile
                          ? Image.file(
                              File(media.url),
                              width: 62.w,
                              height: 62.w,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              media.url,
                              width: 62.w,
                              height: 62.w,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Girodani Gold Lipstick',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          spacing: 8.w,
                          children: [
                            Text(
                              "\$14.99",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: const Color.fromARGB(255, 4, 118, 8),
                              ),
                              child: Center(
                                child: Text(
                                  "30% off",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
