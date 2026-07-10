enum MediaType { image, video, xfile }

class MediaModel {
  final String url;
  final MediaType type;
  final String caption;
  final String music;
  final String hashtag;
  final String referralCode;
  final String link;

  MediaModel({
    required this.url,
    required this.type,
    required this.caption,
    required this.music,
    required this.hashtag,
    required this.referralCode,
    required this.link,
  });
}
