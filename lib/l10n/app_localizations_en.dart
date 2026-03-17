// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Transport Manager Cargo Quiz';

  @override
  String get appSubtitle => 'Pass quickly in your spare time!';

  @override
  String get part1 => 'Freight Transport Business Law';

  @override
  String get part2 => 'Road Transport Vehicle Law';

  @override
  String get part3 => 'Road Traffic Law';

  @override
  String get part4 => 'Labor Standards Law';

  @override
  String get part5 => 'Practical Knowledge and Ability';

  @override
  String get reviewWeakness => 'Review Weakness';

  @override
  String questionsCount(int count) {
    return '$count questions';
  }

  @override
  String get allCategories => 'All Categories';

  @override
  String get shuffleMode => 'Shuffle';

  @override
  String get sequentialMode => 'Sequential';

  @override
  String get premiumUpgrade => 'Premium Upgrade';

  @override
  String get sequentialModeFeature => 'Unlock Sequential Mode';

  @override
  String get sequentialModeDesc =>
      'Solve all questions in order from the first one.';

  @override
  String get adFreeFeature => 'Completely Remove Ads';

  @override
  String get adFreeDesc => 'Hide all ads in the app (banners, videos, etc.)';

  @override
  String get categoryReviewFeature => 'Category Weakness Review';

  @override
  String get categoryReviewDesc =>
      'Filter and review weak questions by part efficiently.';

  @override
  String get buyNow => 'Purchase';

  @override
  String get cancel => 'Cancel';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get restorePurchase => 'Restore Purchases';

  @override
  String get sisterAppTitle => 'Speed learning with\nsister app';

  @override
  String get sisterAppSubtitle => 'Swipe format learning';

  @override
  String get reviewMistakes => 'Review Mistakes';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get retry => 'Retry';
}
