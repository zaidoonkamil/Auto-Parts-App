// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Central Kurdish (`ckb`).
class AppLocalizationsCkb extends AppLocalizations {
  AppLocalizationsCkb([String locale = 'ckb']) : super(locale);

  @override
  String get appTitle => 'تۆتۆ پارت';

  @override
  String get language => 'زمان';

  @override
  String get chooseLanguage => 'زمان هەڵبژێرە';

  @override
  String get languageArabic => 'عەرەبی';

  @override
  String get languageKurdish => 'کوردیی سۆرانی';

  @override
  String get languageSubtitle => 'زمانی ئەپ بگۆڕە لەنێوان عەرەبی و سۆرانی';

  @override
  String get whatsapp => 'واتساپ';

  @override
  String get whatsappSubtitle => 'لێرە لەگەڵمان چات بکە';

  @override
  String get unableToOpenLink => 'کردنەوەی بەستەرەکە نەکرا';

  @override
  String get favorites => 'دڵخوازەکان';

  @override
  String get favoritesSubtitle => 'ئەو بەرهەمانەی پاراستووتە بۆ گەڕانەوە بۆیان';

  @override
  String get loginRequiredFirst => 'پێویستە سەرەتا بچیتە ژوورەوە';

  @override
  String get logout => 'چوونەدەرەوە';

  @override
  String get logoutSubtitle => 'دانانی کۆتایی بۆ دانیشتنی ئێستا و گەڕانەوە بۆ میوان';

  @override
  String get deleteAccount => 'سڕینەوەی هەژمار';

  @override
  String get deleteAccountSubtitle => 'سڕینەوەی کۆتایی بۆ هەموو زانیارییەکانی هەژمار';

  @override
  String get deleteAccountTitle => 'سڕینەوەی هەژمار';

  @override
  String get deleteAccountMessage => 'دڵنیاییت دەتەوێت هەژمارەکەت بە تەواوی بسڕیتەوە؟\nدوای ئەم هەنگاوە ناتوانیت بگەڕێیتەوە و هەموو زانیارییە پەیوەندیدارەکانت دەسڕدرێنەوە.';

  @override
  String get cancel => 'هەڵوەشاندنەوە';

  @override
  String get deletePermanently => 'سڕینەوەی کۆتایی';

  @override
  String get welcomeGuest => 'بەخێربێیت';

  @override
  String get welcomeGuestSubtitle => 'بچۆ ژوورەوە بۆ گەیشتن بە دڵخوازەکان و بەڕێوەبردنی هەژمارەکەت بە ئاسانی';

  @override
  String get login => 'چوونەژوورەوە';

  @override
  String get loginSubtitle => 'چوونە ژوورەوە بۆ هەژمارەکەت بۆ بەکارهێنانی هەموو تایبەتمەندییەکانی فرۆشگا';

  @override
  String get profileLanguageChanged => 'زمانی ئەپ گۆڕدرا';

  @override
  String get appBarTagline => 'پارچەی یەدەکی ڕەسەن';

  @override
  String get operationCompleted => 'پرۆسەکە تەواو بوو';

  @override
  String get productAddedToBasketSuccess => 'بەرهەمەکە بە سەرکەوتوویی زیادکرا بۆ سەبەتەکە';

  @override
  String get searchProductsTitle => 'بەدوای بەرهەم یان پارچەی یەدەک بگەڕێ';

  @override
  String get searchProductsSubtitle => 'باتری، فلتەر، زەیت، بۆاجی';

  @override
  String get categoriesTitle => 'بەشەکان';

  @override
  String get categoriesSubtitle => 'ئەو بەشە هەڵبژێرە کە بۆ ئۆتۆمبێلەکەت گونجاوە';

  @override
  String get featuredProductsTitle => 'دیارترین بەرهەمەکان';

  @override
  String get featuredProductsSubtitle => 'کۆمەڵەیەکی نوێبوونەوە لە پارچەی یەدەک کە هەموو جارێک دەگۆڕێت';

  @override
  String get viewAll => 'بینینی هەموو';

  @override
  String get myAccount => 'هەژمارم';

  @override
  String get myOrders => 'داواکارییەکانم';

  @override
  String get home => 'سەرەکی';

  @override
  String get basketTitle => 'سەبەتە';

  @override
  String get basketSubtitle => 'پێش تەواوکردنی داواکردن بەرهەمەکان بپشکنە';

  @override
  String get currencyShort => 'د.ع';

  @override
  String get quantity => 'بڕ';

  @override
  String get totalLabel => 'کۆی گشتی';

  @override
  String get checkout => 'تەواوکردنی کرین';

  @override
  String orderTotalLabel(Object amount) {
    return 'کۆی داواکاری $amount د.ع';
  }

  @override
  String basketItemsSummary(Object count) {
    return '$count بەرهەمت لە سەبەتی کریندا هەیە';
  }

  @override
  String unitPriceLabel(Object amount) {
    return 'نرخی پارچە $amount';
  }

  @override
  String get basketEmptyTitle => 'سەبەتەکە ئێستا بەتاڵە';

  @override
  String get basketEmptySubtitle => 'هەندێک پارچەی یەدەک زیاد بکە پاشان بگەڕێرەوە بۆ تەواوکردنی داواکاری';

  @override
  String get completeShoppingTitle => 'تەواوکردنی کرین';

  @override
  String get completeShoppingSubtitle => 'زانیارییەکانی گەیاندن بنووسە بۆ تەواوکردنی داواکاری';

  @override
  String get orderCreatedSuccess => 'پرۆسەی داواکردن بە سەرکەوتوویی تەواو بوو';

  @override
  String get confirmOrder => 'پشتڕاستکردنەوەی داواکاری';

  @override
  String prepareItemsCount(Object count) {
    return 'بەدواداچوون بۆ ئامادەکردنی $count بەرهەم';
  }

  @override
  String get reviewOrderInfo => 'پێداچوونەوە بە زانیارییەکانی داواکاری';

  @override
  String reviewOrderInfoSubtitle(Object count) {
    return 'دوای پشتڕاستکردنەوەی زانیارییەکانی گەیاندن، $count بەرهەم ئامادە دەکرێت';
  }

  @override
  String get paymentMethod => 'شێوازی پارەدان';

  @override
  String get cashOnDelivery => 'پارەدان لە کاتی وەرگرتندا';

  @override
  String get shippingInfo => 'زانیاریی گەیاندن';

  @override
  String get phoneNumber => 'ژمارەی مۆبایل';

  @override
  String get enterPhoneNumber => 'ژمارەی مۆبایل بنووسە';

  @override
  String get pleaseEnterPhoneNumber => 'تکایە ژمارەی مۆبایل بنووسە';

  @override
  String get detailedAddress => 'ناونیشانی ورد';

  @override
  String get enterDetailedAddress => 'ناونیشانەکە بە وردی بنووسە';

  @override
  String get pleaseEnterDetailedAddress => 'تکایە ناونیشانەکە بە وردی بنووسە';

  @override
  String myOrdersSavedCount(Object count) {
    return '$count داواکاری لە هەژمارەکەتدا پارێزراون';
  }

  @override
  String orderDateLabel(Object date) {
    return 'بەرواری داواکاری $date';
  }

  @override
  String get orderPieces => 'ژمارەی پارچەکان';

  @override
  String get guestOrdersTitle => 'بچۆ ژوورەوە بۆ بەدواداچوونی داواکارییەکانت';

  @override
  String get guestOrdersSubtitle => 'دوای چوونەژوورەوە هەموو داواکارییە ئێستایی و پێشووەکانت لێرە دەردەکەون.';

  @override
  String get noOrdersTitle => 'هێشتا هیچ داواکارییەک نییە';

  @override
  String get noOrdersSubtitle => 'کاتێک یەکەم داواکاری تەواو بکەیت، وردەکارییەکانی لێرە پیشان دەدرێن.';

  @override
  String get productDetailsTitle => 'وردەکاریی بەرهەم';

  @override
  String get productDetailsSubtitle => 'تایبەتمەندیی پارچەکە و هەڵبژاردەکانی داواکردن';

  @override
  String get availableNow => 'ئێستا بەردەستە';

  @override
  String get iraqiDinar => 'دیناری عێراقی';

  @override
  String get addToBasket => 'زیادکردن بۆ سەبەتە';

  @override
  String piecesCount(Object count) {
    return '$count پارچە';
  }

  @override
  String get productDescription => 'وەسفی بەرهەم';

  @override
  String get sellerInfo => 'زانیاریی فرۆشیار';

  @override
  String get searchProductTitle => 'گەڕان بەدوای بەرهەم';

  @override
  String get searchProductHint => 'ناوی پارچە یان بەرهەم بنووسە';

  @override
  String get startTypingToSearch => 'بە نووسینی ناوی بەرهەم دەستپێبکە بۆ گەڕان';

  @override
  String get noMatchingResults => 'هیچ ئەنجامێکی هاوشێوە نەدۆزرایەوە';

  @override
  String get searchFailed => 'هەڵەیەک ڕوویدا لە کاتی گەڕاندا';

  @override
  String get favoritesEmptyTitle => 'ئێستا هیچ بەرهەمێکی پاشەکەوتکراو نییە';

  @override
  String get favoritesEmptySubtitle => 'کاتێک هەر بەرهەمێک بۆ دڵخواز زیاد بکەیت لێرە پیشان دەدرێت';

  @override
  String get notificationsTitle => 'ئاگادارکردنەوەکان';

  @override
  String get notificationsSubtitle => 'دوایین ئاگادارکردنەوە و نوێکارییەکانی تایبەت بە تۆ';

  @override
  String get notificationsEmptyTitle => 'ئێستا هیچ ئاگادارکردنەوەیەک نییە';

  @override
  String get notificationsEmptySubtitle => 'کاتێک هەر ئاگادارکردنەوەیەکی نوێ بگات، لێرە دەردەکەوێت';
}
