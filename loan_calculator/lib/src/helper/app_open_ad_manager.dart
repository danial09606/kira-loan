import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loan_calculator/src/helper/ad_helper.dart';

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  final Duration maxCacheDuration = const Duration(hours: 4);

  DateTime? _appOpenLoadTime;

  void loadAd() {
    AppOpenAd.load(
      adUnitId: AdHelper.appOpenAdUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable() {
    if (!isAdAvailable) {
      debugPrint('Tried to show ad before available.');
      loadAd();
      return;
    }

    if (_isShowingAd) {
      debugPrint('Tried to show ad while already showing an ad.');
      return;
    }

    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      debugPrint('Maximum cache duration exceeded. Loading another ad.');
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        debugPrint('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );

    _appOpenAd!.show();
  }
}
