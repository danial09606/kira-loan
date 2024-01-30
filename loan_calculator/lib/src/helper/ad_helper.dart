import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6095475364126218/8385949370';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6095475364126218/8883237855';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6095475364126218/7818973161';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6095475364126218/4401067364';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get appOpenAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6095475364126218/2704842317';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6095475364126218/9315887665';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
