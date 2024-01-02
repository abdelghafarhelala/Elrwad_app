import 'dart:io';

class AdsManger {
  static bool _testMode = true;

  // get app id
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544~1458002511";
    } else if (Platform.isIOS) {
      return "";
    } else {
      return "error";
    }
  }

  // get app id
  static String get bannerAdUnitId {
    if (_testMode) {
      return "ca-app-pub-3940256099942544~1458002511";
    } else {
      if (Platform.isAndroid) {
        return "ca-app-pub-7398921363049960~7158884224";
      } else if (Platform.isIOS) {
        return "";
      } else {
        return "error";
      }
    }
  }
}
