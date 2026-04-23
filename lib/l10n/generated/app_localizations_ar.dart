// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'توتو بارت';

  @override
  String get language => 'اللغة';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageKurdish => 'الكردية السورانية';

  @override
  String get languageSubtitle => 'بدّل لغة التطبيق بين العربية والسورانية';

  @override
  String get whatsapp => 'واتساب';

  @override
  String get whatsappSubtitle => 'دردش معنا هنا';

  @override
  String get unableToOpenLink => 'تعذر فتح الرابط';

  @override
  String get favorites => 'المفضلة';

  @override
  String get favoritesSubtitle => 'المنتجات التي حفظتها للرجوع إليها';

  @override
  String get loginRequiredFirst => 'يجب عليك تسجيل الدخول أولاً';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutSubtitle => 'إنهاء الجلسة الحالية والعودة للزائر';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountSubtitle => 'حذف نهائي لجميع بيانات الحساب';

  @override
  String get deleteAccountTitle => 'حذف الحساب';

  @override
  String get deleteAccountMessage => 'هل أنت متأكد أنك تريد حذف حسابك بشكل نهائي؟\nلن تتمكن من التراجع عن هذا الإجراء، وسيتم حذف جميع بياناتك المرتبطة بالحساب.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get deletePermanently => 'حذف نهائي';

  @override
  String get welcomeGuest => 'أهلاً بك';

  @override
  String get welcomeGuestSubtitle => 'سجّل الدخول للوصول إلى المفضلة وإدارة حسابك بسهولة';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get loginSubtitle => 'ادخل إلى حسابك للوصول إلى جميع ميزات المتجر';

  @override
  String get profileLanguageChanged => 'تم تغيير لغة التطبيق';

  @override
  String get appBarTagline => 'قطع غيار أصلية لسيارتك';

  @override
  String get operationCompleted => 'تمت العملية';

  @override
  String get productAddedToBasketSuccess => 'تمت إضافة المنتج إلى السلة بنجاح';

  @override
  String get searchProductsTitle => 'ابحث عن منتج أو قطعة غيار';

  @override
  String get searchProductsSubtitle => 'بطاريات، فلاتر، زيوت، بواجي';

  @override
  String get categoriesTitle => 'الأقسام';

  @override
  String get categoriesSubtitle => 'اختر القسم المناسب لسيارتك';

  @override
  String get featuredProductsTitle => 'أبرز المنتجات';

  @override
  String get featuredProductsSubtitle => 'تشكيلة متجددة من قطع الغيار تتغير في كل مرة';

  @override
  String get viewAll => 'رؤية الكل';

  @override
  String get myAccount => 'حسابي';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get home => 'الرئيسية';

  @override
  String get basketTitle => 'السلة';

  @override
  String get basketSubtitle => 'راجع المنتجات قبل إكمال الطلب';

  @override
  String get currencyShort => 'د.ع';

  @override
  String get quantity => 'الكمية';

  @override
  String get totalLabel => 'المجموع الكلي';

  @override
  String get checkout => 'إكمال الشراء';

  @override
  String orderTotalLabel(Object amount) {
    return 'إجمالي الطلب $amount د.ع';
  }

  @override
  String basketItemsSummary(Object count) {
    return 'لديك $count منتجات في سلة التسوق';
  }

  @override
  String unitPriceLabel(Object amount) {
    return 'القطعة $amount';
  }

  @override
  String get basketEmptyTitle => 'السلة فارغة حالياً';

  @override
  String get basketEmptySubtitle => 'أضف بعض قطع الغيار ثم ارجع هنا لإكمال الطلب';

  @override
  String get completeShoppingTitle => 'إكمال الشراء';

  @override
  String get completeShoppingSubtitle => 'أدخل معلومات التوصيل لإتمام الطلب';

  @override
  String get orderCreatedSuccess => 'تمت عملية الطلب بنجاح';

  @override
  String get confirmOrder => 'تأكيد الطلب';

  @override
  String prepareItemsCount(Object count) {
    return 'متابعة تجهيز $count منتج';
  }

  @override
  String get reviewOrderInfo => 'مراجعة معلومات الطلب';

  @override
  String reviewOrderInfoSubtitle(Object count) {
    return 'سيتم تجهيز $count منتج بعد تأكيد بيانات التوصيل';
  }

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get cashOnDelivery => 'نقداً عند الاستلام';

  @override
  String get shippingInfo => 'بيانات التوصيل';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get enterPhoneNumber => 'ادخل رقم الهاتف';

  @override
  String get pleaseEnterPhoneNumber => 'رجاءاً ادخل رقم الهاتف';

  @override
  String get detailedAddress => 'العنوان التفصيلي';

  @override
  String get enterDetailedAddress => 'ادخل العنوان بالتفصيل';

  @override
  String get pleaseEnterDetailedAddress => 'رجاءاً ادخل العنوان بالتفصيل';

  @override
  String myOrdersSavedCount(Object count) {
    return 'لديك $count طلبات محفوظة في حسابك';
  }

  @override
  String orderDateLabel(Object date) {
    return 'تاريخ الطلب $date';
  }

  @override
  String get orderPieces => 'عدد القطع';

  @override
  String get guestOrdersTitle => 'سجل الدخول لمتابعة طلباتك';

  @override
  String get guestOrdersSubtitle => 'ستظهر هنا جميع الطلبات الحالية والسابقة بعد تسجيل الدخول.';

  @override
  String get noOrdersTitle => 'لا توجد طلبات بعد';

  @override
  String get noOrdersSubtitle => 'عند إتمام أول طلب ستظهر بياناته هنا بشكل منظم.';

  @override
  String get productDetailsTitle => 'تفاصيل المنتج';

  @override
  String get productDetailsSubtitle => 'مواصفات القطعة وخيارات الطلب';

  @override
  String get availableNow => 'متوفر حالياً';

  @override
  String get iraqiDinar => 'دينار عراقي';

  @override
  String get addToBasket => 'أضف للسلة';

  @override
  String piecesCount(Object count) {
    return '$count قطعة';
  }

  @override
  String get productDescription => 'وصف المنتج';

  @override
  String get sellerInfo => 'معلومات البائع';

  @override
  String get searchProductTitle => 'البحث عن منتج';

  @override
  String get searchProductHint => 'اكتب اسم القطعة أو المنتج';

  @override
  String get startTypingToSearch => 'ابدأ بكتابة اسم المنتج للبحث';

  @override
  String get noMatchingResults => 'لا توجد نتائج مطابقة';

  @override
  String get searchFailed => 'حدث خطأ أثناء البحث';

  @override
  String get favoritesEmptyTitle => 'لا توجد منتجات محفوظة حالياً';

  @override
  String get favoritesEmptySubtitle => 'عند إضافة أي منتج إلى المفضلة سيظهر هنا بشكل منظم';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get notificationsSubtitle => 'آخر التنبيهات والتحديثات الخاصة بك';

  @override
  String get notificationsEmptyTitle => 'لا توجد إشعارات حالياً';

  @override
  String get notificationsEmptySubtitle => 'عند وصول أي إشعار جديد سيظهر هنا مباشرة';
}
