enum MediaType { image, video }

class MediaModel {
  final String url;
  final MediaType type;

  MediaModel({
    required this.url,
    required this.type,
  });
}