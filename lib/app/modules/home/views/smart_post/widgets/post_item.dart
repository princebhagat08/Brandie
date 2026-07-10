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
                  _PostMeta(post: post, media: media),
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

class _PostMeta extends StatefulWidget {
  final PostModel post;
  final MediaModel media;

  const _PostMeta({required this.post, required this.media});

  @override
  State<_PostMeta> createState() => _PostMetaState();
}

class _PostMetaState extends State<_PostMeta> {
  bool _isExpanded = false;
  bool _shouldCollapse = false;

  @override
  void didUpdateWidget(covariant _PostMeta oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.media.url != widget.media.url) {
      _isExpanded = false;
    }
    int totalLength = widget.media.caption.length + widget.media.hashtag.length;
    if (totalLength > 65) {
      _shouldCollapse = true;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        text: widget.media.music,
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
              ReadMoreText(
                "${widget.media.caption}\n${widget.media.hashtag}",
                trimMode: TrimMode.Line,
                trimLines: 2,
                trimCollapsedText: " See More",
                trimExpandedText: " See Less",
                delimiter: "...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
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

              SizedBox(height: 2.h),

              Text(
                "Use my referral code: ${widget.media.referralCode}",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),

              Text(
                "Use my referral link: ${widget.media.link}",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
