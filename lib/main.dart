import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'bloc_observer.dart';
import 'core/localization/ckb_fallback_localizations.dart';
import 'core/localization/locale_cubit.dart';
import 'core/network/local/cache_helper.dart';
import 'core/network/remote/dio_helper.dart';
import 'core/styles/themes.dart';
import 'l10n/generated/app_localizations.dart';
import 'features/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.Debug.setAlertLevel(OSLogLevel.none);
  OneSignal.initialize("9d950047-396a-40d1-bae0-bc91808cab30");
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocaleCubit(),
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeService().lightTheme,
            locale: locale,
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: child ?? const SizedBox.shrink(),
              );
            },
            supportedLocales: const [
              Locale('ar'),
              Locale('ckb'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              CkbFallbackMaterialLocalizationsDelegate(),
              CkbFallbackCupertinoLocalizationsDelegate(),
              CkbFallbackWidgetsLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
