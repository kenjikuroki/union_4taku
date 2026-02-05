import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseManager {
  static final PurchaseManager instance = PurchaseManager._internal();
  PurchaseManager._internal();

  final InAppPurchase _iap = InAppPurchase.instance;
  final String _productId = 'unlock_unkou_4';
  static const String _isPremiumKey = 'is_premium_user';

  final ValueNotifier<bool> isPremiumNotifier = ValueNotifier(false);
  bool get isPremium => isPremiumNotifier.value;

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  Future<void> init() async {
    // 1. Load local status
    final prefs = await SharedPreferences.getInstance();
    isPremiumNotifier.value = prefs.getBool(_isPremiumKey) ?? false;

    // 2. Listen to purchase updates
    final purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdated,
      onDone: () {
        _subscription?.cancel();
      },
      onError: (error) {
        debugPrint('PurchaseManager: Error listening to purchase stream: $error');
      },
    );
  }

  Future<void> buyPremium() async {
    if (await _iap.isAvailable()) {
      final Set<String> ids = {_productId};
      final ProductDetailsResponse response = await _iap.queryProductDetails(ids);
      
      if (response.notFoundIDs.isNotEmpty) {
        debugPrint('PurchaseManager: Product not found: ${response.notFoundIDs}');
        // Handle error: product not found
        return;
      }

      final List<ProductDetails> products = response.productDetails;
      if (products.isEmpty) {
        debugPrint('PurchaseManager: No products found');
        return;
      }

      final ProductDetails productDetails = products.first;
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
      
      // Initiate purchase
      _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } else {
      debugPrint('PurchaseManager: Store not available');
    }
  }

  Future<void> restorePurchases() async {
    if (await _iap.isAvailable()) {
      await _iap.restorePurchases();
    }
  }

  Future<void> _onPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Show pending UI if needed
        debugPrint('PurchaseManager: Purchase pending...');
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          debugPrint('PurchaseManager: Purchase error: ${purchaseDetails.error}');
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
                   purchaseDetails.status == PurchaseStatus.restored) {
          
          await _deliverProduct(purchaseDetails);
        }
        
        if (purchaseDetails.pendingCompletePurchase) {
          await _iap.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> _deliverProduct(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID == _productId) {
      debugPrint('PurchaseManager: Premium unlocked!');
      isPremiumNotifier.value = true;
      
      // Persist status
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isPremiumKey, true);
    }
  }

  void dispose() {
    _subscription?.cancel();
    isPremiumNotifier.dispose();
  }
}
