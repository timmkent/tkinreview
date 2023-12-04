import 'package:tkinreview/tk_database.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TKInReview {
  static final TKInReview _singleton = TKInReview._internal();
  TKInReview._internal();
  factory TKInReview() {
    return _singleton;
  }

  static initialize({required String appShort}) async {
    final inReviewVersionsSnap = await TKDatabase.configs().ref(appShort).child('inReviewVersion').get();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    final inReviewVersion = inReviewVersionsSnap.value as String;
    print("CurrentVersion:$currentVersion  inReviewVersion:$inReviewVersion");
    return inReviewVersion == currentVersion;
  }
}
