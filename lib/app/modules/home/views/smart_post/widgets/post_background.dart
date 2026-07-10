import 'package:flutter/material.dart';

import '../../../../../data/model/post_model.dart';

class PostBackground extends StatelessWidget {
  final PostModel post;
  const PostBackground({super.key,required this.post});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        post.media[0].url,
        fit: BoxFit.cover,
      ),
    );
  }
}