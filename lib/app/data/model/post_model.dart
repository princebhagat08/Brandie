import 'media_model.dart';

class PostModel {
  final String id;

  final String userImage;
  final String userName;

  final String caption;

  final String musicName;

  final List<MediaModel> media;

  PostModel({
    required this.id,
    required this.userImage,
    required this.userName,
    required this.caption,
    required this.musicName,
    required this.media,
  });
}