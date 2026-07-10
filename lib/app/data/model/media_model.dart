enum MediaType { image, video, xfile }

class MediaModel {
  final String url;
  final MediaType type;
  String caption;
  final String music;
  String hashtag;
  String referralCode;
  String link;

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
