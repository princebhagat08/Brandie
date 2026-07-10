import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../data/model/media_model.dart';
import '../../../../../data/model/post_model.dart';
import '../../../controllers/home_controller.dart';
import 'post_background.dart';

class PostItem extends StatelessWidget {
  final PostModel post;

  const PostItem({
    super.key,
    required this.post,
  });

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
              padding: EdgeInsets.fromLTRB(16, 16, 16, 120.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PostHeader(
                    post: post,
                    media: media,
                    currentMediaIndex: currentMediaIndex,
                  ),
                  const Spacer(),
                  _PostMeta(post: post, media: media)
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
        CircleAvatar(
          radius: 26.r,
          backgroundImage: AssetImage(post.userImage),
        ),
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
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
       if(post.media.length>1) Container(
          padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(80),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Text(
            '${currentMediaIndex + 1} of ${post.media.length}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp
            ),
          ),
        ),
      ],
    );
  }
}

class _PostMeta extends StatelessWidget {
  final PostModel post;
  final MediaModel media;

  const _PostMeta({
    required this.post,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "@${post.userName.toLowerCase()}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          media.caption,
          style: const TextStyle(
            color: Colors.white,
            height: 1.35,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.16),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.music_note_rounded, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  media.musicName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PostActions extends StatelessWidget {
  final MediaModel media;

  const _PostActions({
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ActionButton(
          icon: Icons.favorite_border_rounded,
          label: media.type == MediaType.video ? "18.2K" : "9.4K",
        ),
        const SizedBox(height: 18),
        _ActionButton(
          icon: Icons.chat_bubble_outline_rounded,
          label: "482",
        ),
        const SizedBox(height: 18),
        _ActionButton(
          icon: Icons.send_rounded,
          label: "Share",
        ),
        const SizedBox(height: 18),
        _ActionButton(
          icon: Icons.bookmark_border_rounded,
          label: "Save",
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.22),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
