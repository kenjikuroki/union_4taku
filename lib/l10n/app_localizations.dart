import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ja, this message translates to:
  /// **'運行管理者 貨物 4択問題'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In ja, this message translates to:
  /// **'スキマ時間でサクサク合格！4択問題'**
  String get appSubtitle;

  /// No description provided for @part1.
  ///
  /// In ja, this message translates to:
  /// **'貨物自動車運送事業法'**
  String get part1;

  /// No description provided for @part2.
  ///
  /// In ja, this message translates to:
  /// **'道路運送車両法'**
  String get part2;

  /// No description provided for @part3.
  ///
  /// In ja, this message translates to:
  /// **'道路交通法'**
  String get part3;

  /// No description provided for @part4.
  ///
  /// In ja, this message translates to:
  /// **'労働基準法'**
  String get part4;

  /// No description provided for @part5.
  ///
  /// In ja, this message translates to:
  /// **'実務上の知識及び能力'**
  String get part5;

  /// No description provided for @reviewWeakness.
  ///
  /// In ja, this message translates to:
  /// **'苦手を復習する'**
  String get reviewWeakness;

  /// No description provided for @questionsCount.
  ///
  /// In ja, this message translates to:
  /// **'{count}問'**
  String questionsCount(int count);

  /// No description provided for @allCategories.
  ///
  /// In ja, this message translates to:
  /// **'全カテゴリー'**
  String get allCategories;

  /// No description provided for @shuffleMode.
  ///
  /// In ja, this message translates to:
  /// **'シャッフル'**
  String get shuffleMode;

  /// No description provided for @sequentialMode.
  ///
  /// In ja, this message translates to:
  /// **'順番通り'**
  String get sequentialMode;

  /// No description provided for @premiumUpgrade.
  ///
  /// In ja, this message translates to:
  /// **'プレミアムアップグレード'**
  String get premiumUpgrade;

  /// No description provided for @sequentialModeFeature.
  ///
  /// In ja, this message translates to:
  /// **'「連続」モードの解放'**
  String get sequentialModeFeature;

  /// No description provided for @sequentialModeDesc.
  ///
  /// In ja, this message translates to:
  /// **'1問目から順番にすべての問題を解くことができます。'**
  String get sequentialModeDesc;

  /// No description provided for @adFreeFeature.
  ///
  /// In ja, this message translates to:
  /// **'広告を完全に非表示'**
  String get adFreeFeature;

  /// No description provided for @adFreeDesc.
  ///
  /// In ja, this message translates to:
  /// **'アプリ内のあらゆる広告（バナー、動画など）を非表示にします。'**
  String get adFreeDesc;

  /// No description provided for @categoryReviewFeature.
  ///
  /// In ja, this message translates to:
  /// **'カテゴリー別の弱点復習機能'**
  String get categoryReviewFeature;

  /// No description provided for @categoryReviewDesc.
  ///
  /// In ja, this message translates to:
  /// **'苦手な問題をパートごとに絞って、効率よく復習できます。'**
  String get categoryReviewDesc;

  /// No description provided for @buyNow.
  ///
  /// In ja, this message translates to:
  /// **'購入する'**
  String get buyNow;

  /// No description provided for @cancel.
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get cancel;

  /// No description provided for @selectCategory.
  ///
  /// In ja, this message translates to:
  /// **'カテゴリーを選択'**
  String get selectCategory;

  /// No description provided for @restorePurchase.
  ///
  /// In ja, this message translates to:
  /// **'購入を復元する'**
  String get restorePurchase;

  /// No description provided for @sisterAppTitle.
  ///
  /// In ja, this message translates to:
  /// **'サクサク解ける\n姉妹アプリはこちら'**
  String get sisterAppTitle;

  /// No description provided for @sisterAppSubtitle.
  ///
  /// In ja, this message translates to:
  /// **'スワイプ形式で高速学習'**
  String get sisterAppSubtitle;

  /// No description provided for @reviewMistakes.
  ///
  /// In ja, this message translates to:
  /// **'ミスを確認'**
  String get reviewMistakes;

  /// No description provided for @backToHome.
  ///
  /// In ja, this message translates to:
  /// **'ホームに戻る'**
  String get backToHome;

  /// No description provided for @retry.
  ///
  /// In ja, this message translates to:
  /// **'リトライ'**
  String get retry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
