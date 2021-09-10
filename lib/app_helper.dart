import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return ""; // Add your android banner id
    } else if (Platform.isIOS) {
      return ""; // Add your ios banner id
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAd {
    if (Platform.isAndroid) {
      return ""; // Add your android interstitial id
    } else if (Platform.isIOS) {
      return ""; // Add your ios interstitial id
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
