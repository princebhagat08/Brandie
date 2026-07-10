import 'media_model.dart';

class PostModel {
  final String id;

  final String userImage;
  final String userName;

  final List<MediaModel> media;

  PostModel({
    required this.id,
    required this.userImage,
    required this.userName,
    required this.media,
  });
}
