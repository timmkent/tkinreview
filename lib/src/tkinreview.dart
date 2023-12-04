import 'package:firebase_database/firebase_database.dart';
import 'package:tkinreview/tk_database.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TKInReview {
  static final TKInReview _singleton = TKInReview._internal();
  TKInReview._internal();
  factory TKInReview() {
    return _singleton;
  }

  bool? _isInReview;

  static initialize({required String appShort, required FirebaseDatabase firebaseDatabase}) async {
    final snap = await firebaseDatabase.ref('underReview').child('underReview').get();
    final swfForce = snap.value as bool? ?? false;
    if (swfForce) return true;
    final inReviewVersionsSnap = await TKDatabase.configs().ref(appShort).child('inReviewVersion').get();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    final inReviewVersion = inReviewVersionsSnap.value as String;
    print("CurrentVersion:$currentVersion  inReviewVersion:$inReviewVersion");
    return inReviewVersion == currentVersion;
  }

  static bool get isInReview {
    assert(_singleton._isInReview != null, 'TKInReview not correctly initialzed');
    return _singleton._isInReview!;
  }
}
