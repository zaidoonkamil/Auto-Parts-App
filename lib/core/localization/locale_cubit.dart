import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/local/cache_helper.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(_initialLocale());

  static const String localeCacheKey = 'app_locale';

  static Locale _initialLocale() {
    final savedCode = CacheHelper.getData(key: localeCacheKey) as String?;
    if (savedCode == 'ckb') {
      return const Locale('ckb');
    }
    return const Locale('ar');
  }

  Future<void> changeLocale(String languageCode) async {
    final locale = languageCode == 'ckb' ? const Locale('ckb') : const Locale('ar');
    await CacheHelper.saveData(key: localeCacheKey, value: locale.languageCode);
    emit(locale);
  }
}
