import 'package:flutter/material.dart';

import '../../../../../data/model/post_model.dart';
import 'post_background.dart';

class PostItem extends StatelessWidget {

   final PostModel post;

   const PostItem({
      super.key,
      required this.post,
   });

   @override
   Widget build(BuildContext context){

      return Stack(

        children:[

            PostBackground(post:post),

            // PostHeader(post),

            // PostCaption(post),

            // MusicWidget(post),

            // QuickShare(),

            // BottomNav(),

            // PageIndicator(),

        ],

      );

   }

}