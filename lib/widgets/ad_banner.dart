import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../utils/ad_manager.dart';
import '../utils/purchase_manager.dart';
import 'banner_ad_placeholder.dart';

class AdBanner extends StatefulWidget {
  final String? adKey;
  // If true, the ad is not disposed when this widget is disposed (e.g. for Home screen).
  final bool keepAlive; 

  const AdBanner({
    super.key, 
    this.adKey,
    this.keepAlive = false,
  });

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  ValueNotifier<bool>? _loadingNotifier; // To track listener for cleanup
  
  String get _adUnitId {
    if (useTestAds) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }
    return Platform.isAndroid
        ? 'ca-app-pub-3331079517737737/4444615495'
        : 'ca-app-pub-3331079517737737/7128272208';
  }
  
  @override
  void initState() {
    super.initState();
    _initAd();
  }

  void _initAd() {
    if (widget.adKey != null) {
      final preloaded = AdManager.instance.consumeAd(widget.adKey!, keep: widget.keepAlive);
      if (preloaded != null) {
        _bannerAd = preloaded.ad;
        _loadingNotifier = preloaded.isLoaded;
        _isLoaded = _loadingNotifier!.value;
        
        // Listen to further updates
        _loadingNotifier!.addListener(_onPreloadedAdChange);
        return;
      }
    }

    _loadAd();
  }
  
  void _onPreloadedAdChange() {
    if (!mounted) return;
    if (_loadingNotifier != null) {
      setState(() {
        _isLoaded = _loadingNotifier!.value;
      });
    }
  }

  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: _adUnitId, 
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded (fallback).');
          if (mounted) {
            setState(() {
              _isLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _loadingNotifier?.removeListener(_onPreloadedAdChange);
    
    if (!widget.keepAlive) {
      _bannerAd?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: PurchaseManager.instance.isPremiumNotifier,
      builder: (context, isPremium, child) {
        if (isPremium) {
           return const SizedBox.shrink();
        }
        
        if (_isLoaded && _bannerAd != null) {
          return SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          );
        }
        return const BannerAdPlaceholder();
      },
    );
  }
}
