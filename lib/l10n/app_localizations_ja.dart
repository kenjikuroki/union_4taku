// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '運行管理者 貨物 4択問題';

  @override
  String get appSubtitle => 'スキマ時間でサクサク合格！4択問題';

  @override
  String get part1 => '貨物自動車運送事業法';

  @override
  String get part2 => '道路運送車両法';

  @override
  String get part3 => '道路交通法';

  @override
  String get part4 => '労働基準法';

  @override
  String get part5 => '実務上の知識及び能力';

  @override
  String get reviewWeakness => '苦手を復習する';

  @override
  String questionsCount(int count) {
    return '$count問';
  }

  @override
  String get allCategories => '全カテゴリー';

  @override
  String get shuffleMode => 'シャッフル';

  @override
  String get sequentialMode => '順番通り';

  @override
  String get premiumUpgrade => 'プレミアムアップグレード';

  @override
  String get sequentialModeFeature => '「連続」モードの解放';

  @override
  String get sequentialModeDesc => '1問目から順番にすべての問題を解くことができます。';

  @override
  String get adFreeFeature => '広告を完全に非表示';

  @override
  String get adFreeDesc => 'アプリ内のあらゆる広告（バナー、動画など）を非表示にします。';

  @override
  String get categoryReviewFeature => 'カテゴリー別の弱点復習機能';

  @override
  String get categoryReviewDesc => '苦手な問題をパートごとに絞って、効率よく復習できます。';

  @override
  String get buyNow => '購入する';

  @override
  String get cancel => 'キャンセル';

  @override
  String get selectCategory => 'カテゴリーを選択';

  @override
  String get restorePurchase => '購入を復元する';

  @override
  String get sisterAppTitle => 'サクサク解ける\n姉妹アプリはこちら';

  @override
  String get sisterAppSubtitle => 'スワイプ形式で高速学習';

  @override
  String get reviewMistakes => 'ミスを確認';

  @override
  String get backToHome => 'ホームに戻る';

  @override
  String get retry => 'リトライ';
}
