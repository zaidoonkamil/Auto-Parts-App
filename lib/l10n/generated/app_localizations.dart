import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_ckb.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('ckb')
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'توتو بارت'**
  String get appTitle;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @chooseLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اختر اللغة'**
  String get chooseLanguage;

  /// No description provided for @languageArabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @languageKurdish.
  ///
  /// In ar, this message translates to:
  /// **'الكردية السورانية'**
  String get languageKurdish;

  /// No description provided for @languageSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'بدّل لغة التطبيق بين العربية والسورانية'**
  String get languageSubtitle;

  /// No description provided for @whatsapp.
  ///
  /// In ar, this message translates to:
  /// **'واتساب'**
  String get whatsapp;

  /// No description provided for @whatsappSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'دردش معنا هنا'**
  String get whatsappSubtitle;

  /// No description provided for @unableToOpenLink.
  ///
  /// In ar, this message translates to:
  /// **'تعذر فتح الرابط'**
  String get unableToOpenLink;

  /// No description provided for @favorites.
  ///
  /// In ar, this message translates to:
  /// **'المفضلة'**
  String get favorites;

  /// No description provided for @favoritesSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'المنتجات التي حفظتها للرجوع إليها'**
  String get favoritesSubtitle;

  /// No description provided for @loginRequiredFirst.
  ///
  /// In ar, this message translates to:
  /// **'يجب عليك تسجيل الدخول أولاً'**
  String get loginRequiredFirst;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @logoutSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء الجلسة الحالية والعودة للزائر'**
  String get logoutSubtitle;

  /// No description provided for @deleteAccount.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب'**
  String get deleteAccount;

  /// No description provided for @deleteAccountSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف نهائي لجميع بيانات الحساب'**
  String get deleteAccountSubtitle;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountMessage.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد حذف حسابك بشكل نهائي؟\nلن تتمكن من التراجع عن هذا الإجراء، وسيتم حذف جميع بياناتك المرتبطة بالحساب.'**
  String get deleteAccountMessage;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @deletePermanently.
  ///
  /// In ar, this message translates to:
  /// **'حذف نهائي'**
  String get deletePermanently;

  /// No description provided for @welcomeGuest.
  ///
  /// In ar, this message translates to:
  /// **'أهلاً بك'**
  String get welcomeGuest;

  /// No description provided for @welcomeGuestSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'سجّل الدخول للوصول إلى المفضلة وإدارة حسابك بسهولة'**
  String get welcomeGuestSubtitle;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get login;

  /// No description provided for @loginSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'ادخل إلى حسابك للوصول إلى جميع ميزات المتجر'**
  String get loginSubtitle;

  /// No description provided for @profileLanguageChanged.
  ///
  /// In ar, this message translates to:
  /// **'تم تغيير لغة التطبيق'**
  String get profileLanguageChanged;

  /// No description provided for @appBarTagline.
  ///
  /// In ar, this message translates to:
  /// **'قطع غيار أصلية لسيارتك'**
  String get appBarTagline;

  /// No description provided for @operationCompleted.
  ///
  /// In ar, this message translates to:
  /// **'تمت العملية'**
  String get operationCompleted;

  /// No description provided for @productAddedToBasketSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تمت إضافة المنتج إلى السلة بنجاح'**
  String get productAddedToBasketSuccess;

  /// No description provided for @searchProductsTitle.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن منتج أو قطعة غيار'**
  String get searchProductsTitle;

  /// No description provided for @searchProductsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'بطاريات، فلاتر، زيوت، بواجي'**
  String get searchProductsSubtitle;

  /// No description provided for @categoriesTitle.
  ///
  /// In ar, this message translates to:
  /// **'الأقسام'**
  String get categoriesTitle;

  /// No description provided for @categoriesSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر القسم المناسب لسيارتك'**
  String get categoriesSubtitle;

  /// No description provided for @featuredProductsTitle.
  ///
  /// In ar, this message translates to:
  /// **'أبرز المنتجات'**
  String get featuredProductsTitle;

  /// No description provided for @featuredProductsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تشكيلة متجددة من قطع الغيار تتغير في كل مرة'**
  String get featuredProductsSubtitle;

  /// No description provided for @viewAll.
  ///
  /// In ar, this message translates to:
  /// **'رؤية الكل'**
  String get viewAll;

  /// No description provided for @myAccount.
  ///
  /// In ar, this message translates to:
  /// **'حسابي'**
  String get myAccount;

  /// No description provided for @myOrders.
  ///
  /// In ar, this message translates to:
  /// **'طلباتي'**
  String get myOrders;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @basketTitle.
  ///
  /// In ar, this message translates to:
  /// **'السلة'**
  String get basketTitle;

  /// No description provided for @basketSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'راجع المنتجات قبل إكمال الطلب'**
  String get basketSubtitle;

  /// No description provided for @currencyShort.
  ///
  /// In ar, this message translates to:
  /// **'د.ع'**
  String get currencyShort;

  /// No description provided for @quantity.
  ///
  /// In ar, this message translates to:
  /// **'الكمية'**
  String get quantity;

  /// No description provided for @totalLabel.
  ///
  /// In ar, this message translates to:
  /// **'المجموع الكلي'**
  String get totalLabel;

  /// No description provided for @checkout.
  ///
  /// In ar, this message translates to:
  /// **'إكمال الشراء'**
  String get checkout;

  /// No description provided for @orderTotalLabel.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الطلب {amount} د.ع'**
  String orderTotalLabel(Object amount);

  /// No description provided for @basketItemsSummary.
  ///
  /// In ar, this message translates to:
  /// **'لديك {count} منتجات في سلة التسوق'**
  String basketItemsSummary(Object count);

  /// No description provided for @unitPriceLabel.
  ///
  /// In ar, this message translates to:
  /// **'القطعة {amount}'**
  String unitPriceLabel(Object amount);

  /// No description provided for @basketEmptyTitle.
  ///
  /// In ar, this message translates to:
  /// **'السلة فارغة حالياً'**
  String get basketEmptyTitle;

  /// No description provided for @basketEmptySubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أضف بعض قطع الغيار ثم ارجع هنا لإكمال الطلب'**
  String get basketEmptySubtitle;

  /// No description provided for @completeShoppingTitle.
  ///
  /// In ar, this message translates to:
  /// **'إكمال الشراء'**
  String get completeShoppingTitle;

  /// No description provided for @completeShoppingSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل معلومات التوصيل لإتمام الطلب'**
  String get completeShoppingSubtitle;

  /// No description provided for @orderCreatedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تمت عملية الطلب بنجاح'**
  String get orderCreatedSuccess;

  /// No description provided for @confirmOrder.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الطلب'**
  String get confirmOrder;

  /// No description provided for @prepareItemsCount.
  ///
  /// In ar, this message translates to:
  /// **'متابعة تجهيز {count} منتج'**
  String prepareItemsCount(Object count);

  /// No description provided for @reviewOrderInfo.
  ///
  /// In ar, this message translates to:
  /// **'مراجعة معلومات الطلب'**
  String get reviewOrderInfo;

  /// No description provided for @reviewOrderInfoSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'سيتم تجهيز {count} منتج بعد تأكيد بيانات التوصيل'**
  String reviewOrderInfoSubtitle(Object count);

  /// No description provided for @paymentMethod.
  ///
  /// In ar, this message translates to:
  /// **'طريقة الدفع'**
  String get paymentMethod;

  /// No description provided for @cashOnDelivery.
  ///
  /// In ar, this message translates to:
  /// **'نقداً عند الاستلام'**
  String get cashOnDelivery;

  /// No description provided for @shippingInfo.
  ///
  /// In ar, this message translates to:
  /// **'بيانات التوصيل'**
  String get shippingInfo;

  /// No description provided for @phoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'ادخل رقم الهاتف'**
  String get enterPhoneNumber;

  /// No description provided for @pleaseEnterPhoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رجاءاً ادخل رقم الهاتف'**
  String get pleaseEnterPhoneNumber;

  /// No description provided for @detailedAddress.
  ///
  /// In ar, this message translates to:
  /// **'العنوان التفصيلي'**
  String get detailedAddress;

  /// No description provided for @enterDetailedAddress.
  ///
  /// In ar, this message translates to:
  /// **'ادخل العنوان بالتفصيل'**
  String get enterDetailedAddress;

  /// No description provided for @pleaseEnterDetailedAddress.
  ///
  /// In ar, this message translates to:
  /// **'رجاءاً ادخل العنوان بالتفصيل'**
  String get pleaseEnterDetailedAddress;

  /// No description provided for @myOrdersSavedCount.
  ///
  /// In ar, this message translates to:
  /// **'لديك {count} طلبات محفوظة في حسابك'**
  String myOrdersSavedCount(Object count);

  /// No description provided for @orderDateLabel.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الطلب {date}'**
  String orderDateLabel(Object date);

  /// No description provided for @orderPieces.
  ///
  /// In ar, this message translates to:
  /// **'عدد القطع'**
  String get orderPieces;

  /// No description provided for @guestOrdersTitle.
  ///
  /// In ar, this message translates to:
  /// **'سجل الدخول لمتابعة طلباتك'**
  String get guestOrdersTitle;

  /// No description provided for @guestOrdersSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'ستظهر هنا جميع الطلبات الحالية والسابقة بعد تسجيل الدخول.'**
  String get guestOrdersSubtitle;

  /// No description provided for @noOrdersTitle.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات بعد'**
  String get noOrdersTitle;

  /// No description provided for @noOrdersSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'عند إتمام أول طلب ستظهر بياناته هنا بشكل منظم.'**
  String get noOrdersSubtitle;

  /// No description provided for @productDetailsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل المنتج'**
  String get productDetailsTitle;

  /// No description provided for @productDetailsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'مواصفات القطعة وخيارات الطلب'**
  String get productDetailsSubtitle;

  /// No description provided for @availableNow.
  ///
  /// In ar, this message translates to:
  /// **'متوفر حالياً'**
  String get availableNow;

  /// No description provided for @iraqiDinar.
  ///
  /// In ar, this message translates to:
  /// **'دينار عراقي'**
  String get iraqiDinar;

  /// No description provided for @addToBasket.
  ///
  /// In ar, this message translates to:
  /// **'أضف للسلة'**
  String get addToBasket;

  /// No description provided for @piecesCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} قطعة'**
  String piecesCount(Object count);

  /// No description provided for @productDescription.
  ///
  /// In ar, this message translates to:
  /// **'وصف المنتج'**
  String get productDescription;

  /// No description provided for @sellerInfo.
  ///
  /// In ar, this message translates to:
  /// **'معلومات البائع'**
  String get sellerInfo;

  /// No description provided for @searchProductTitle.
  ///
  /// In ar, this message translates to:
  /// **'البحث عن منتج'**
  String get searchProductTitle;

  /// No description provided for @searchProductHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب اسم القطعة أو المنتج'**
  String get searchProductHint;

  /// No description provided for @startTypingToSearch.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ بكتابة اسم المنتج للبحث'**
  String get startTypingToSearch;

  /// No description provided for @noMatchingResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج مطابقة'**
  String get noMatchingResults;

  /// No description provided for @searchFailed.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء البحث'**
  String get searchFailed;

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد منتجات محفوظة حالياً'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesEmptySubtitle.
  ///
  /// In ar, this message translates to:
  /// **'عند إضافة أي منتج إلى المفضلة سيظهر هنا بشكل منظم'**
  String get favoritesEmptySubtitle;

  /// No description provided for @notificationsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notificationsTitle;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'آخر التنبيهات والتحديثات الخاصة بك'**
  String get notificationsSubtitle;

  /// No description provided for @notificationsEmptyTitle.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد إشعارات حالياً'**
  String get notificationsEmptyTitle;

  /// No description provided for @notificationsEmptySubtitle.
  ///
  /// In ar, this message translates to:
  /// **'عند وصول أي إشعار جديد سيظهر هنا مباشرة'**
  String get notificationsEmptySubtitle;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'ckb'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'ckb': return AppLocalizationsCkb();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
