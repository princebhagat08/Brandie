import 'package:brandie/app/data/model/media_model.dart';

class SharePayload {
  final String caption;
  final String hashtag;
  final String referralCode;
  final String link;
  final String userName;

  const SharePayload({
    required this.caption,
    required this.hashtag,
    required this.referralCode,
    required this.link,
    required this.userName,
  });

  factory SharePayload.from(String userName, MediaModel media) {
    return SharePayload(
      caption: media.caption,
      hashtag: media.hashtag,
      referralCode: media.referralCode,
      link: media.link,
      userName: userName,
    );
  }

  String get fullText =>
      '$caption\n$hashtag\nUse my referral code: $referralCode\nUse my referral link: $link\nShared by $userName';
}