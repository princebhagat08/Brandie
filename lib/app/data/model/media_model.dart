enum MediaType { image, video }

class MediaModel {
  final String url;
  final MediaType type;
  final String caption;
  final String musicName;

  MediaModel({
    required this.url,
    required this.type,
    required this.caption,
    required this.musicName,
  });
}
