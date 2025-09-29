import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/check_update.dart';
import 'package:eco_dumy/core/classes/cashe_helper.dart';
import 'package:eco_dumy/featuers/auth/cubit/auth_cubit.dart';
import 'package:eco_dumy/featuers/auth/screen/login_screen.dart';
import 'package:eco_dumy/featuers/product/cubit/product_cubit.dart';
import 'package:eco_dumy/featuers/home/cubit/home_cubit.dart';
 import 'package:eco_dumy/featuers/login/ui/login_screen.dart';
import 'package:eco_dumy/featuers/root/cubit/root_cubit.dart';
import 'package:eco_dumy/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/classes/keys.dart';
import 'core/classes/notification.dart';
import 'core/constant/app_theme/app_theme.dart';
import 'core/ui/screens/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  // await FireBaseNotification().initNotification();
  if (defaultTargetPlatform == TargetPlatform.android) {
    await checkForUpdate();
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('en'),
      useOnlyLangCode: true,
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => RootCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ProductCubit()),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        splitScreenMode: false,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            navigatorKey: Keys.navigatorKey,
            title: 'Task App',
            theme: appThemeData[AppTheme.light],
            home: CacheHelper.token != null ? SplashSscreen1() : LoginScreen(),
          );
        },
      ),
    );
  }
}
