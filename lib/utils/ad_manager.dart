import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'purchase_manager.dart';

// --- テスト広告・本番広告 切り替えフラグ ---
// 本番移行時にここを false にすると、すべての広告が本番用IDに切り替わります。
const bool useTestAds = true;

class PreloadedAd {
  final BannerAd ad;
  final ValueNotifier<bool> isLoaded = ValueNotifier(false);

  PreloadedAd(this.ad);

  void dispose() {
    ad.dispose();
    isLoaded.dispose();
  }
}

class AdManager {
  static final AdManager instance = AdManager._internal();
  AdManager._internal();

  final Map<String, PreloadedAd> _ads = {};

  String get _adUnitId {
    if (useTestAds) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }
    return Platform.isAndroid 
        ? 'ca-app-pub-3331079517737737/4444615495' 
        : 'ca-app-pub-3331079517737737/6823059991';
  }

  void preloadAd(String key) {
    if (PurchaseManager.instance.isPremium) return;
    if (_ads.containsKey(key)) {
      // Already preloading or loaded
      return;
    }

    final unitId = _adUnitId;

    final ad = BannerAd(
      adUnitId: unitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('AdManager: Ad $key loaded.');
          _ads[key]?.isLoaded.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('AdManager: Ad $key failed to load: $err');
          ad.dispose();
          _ads.remove(key);
        },
      ),
    );

    final preloadedAd = PreloadedAd(ad);
    _ads[key] = preloadedAd;
    ad.load();
  }

  PreloadedAd? getAd(String key) {
    if (PurchaseManager.instance.isPremium) return null;
    return _ads[key];
  }
  
  /// Returns the ad and removes it from manager (transfer ownership)
  /// If [keep] is true, it retains in manager (shared ownership/singleton usage like Home).
  PreloadedAd? consumeAd(String key, {bool keep = false}) {
    if (PurchaseManager.instance.isPremium) return null;
    if (keep) {
      return _ads[key];
    }
    return _ads.remove(key);
  }

  // Interstitial Ad
  InterstitialAd? _interstitialAd;
  
  String get _interstitialAdUnitId {
    if (useTestAds) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    }
    return Platform.isAndroid
        ? 'ca-app-pub-3331079517737737/8231671474'
        : 'ca-app-pub-3331079517737737/7531644610';
  }

  void preloadInterstitial() {
    if (PurchaseManager.instance.isPremium) return;
    // If already loaded or loading, skip? 
    // Simplified: just try to load if null.
    if (_interstitialAd != null) return;

    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId, 
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('AdManager: Interstitial loaded.');
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          debugPrint('AdManager: Interstitial failed to load: $err');
          _interstitialAd = null;
        },
      ),
    );
  }

  /// Shows the interstitial ad if available.
  /// [onComplete] is called when the ad is dismissed or if it fails to show/load.
  void showInterstitial({required VoidCallback onComplete}) {
    if (PurchaseManager.instance.isPremium) {
      onComplete();
      return;
    }
    if (_interstitialAd == null) {
      debugPrint('AdManager: No interstitial ready, skipping.');
      onComplete();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('AdManager: Interstitial dismissed.');
        ad.dispose();
        _interstitialAd = null;
        onComplete();
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        debugPrint('AdManager: Interstitial failed to show: $err');
        ad.dispose();
        _interstitialAd = null;
        onComplete();
      },
    );

    _interstitialAd!.show();
    // Note: don't set null here immediately, wait for callbacks
  }
  
  void disposeAll() {
    for (var ad in _ads.values) {
      ad.dispose();
    }
    _ads.clear();
    _interstitialAd?.dispose();
    _interstitialAd = null;
  }
}
