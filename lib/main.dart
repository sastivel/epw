
import 'package:EPW_mobile/screens/login/view/login_screen.dart';
import 'package:EPW_mobile/utils/string_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sizer/sizer.dart';

import 'core/injection/bloc_injection.dart';
import 'core/injection/injection.dart';
import 'core/injection/usecase_injection.dart';
import 'package:easy_localization/easy_localization.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  //await configureDependencies();
  await init();
  await injectUseCases();
  await injectBloc();

  runApp(
    HookedBlocConfigProvider(
      injector: () => dl.get,
      builderCondition: (state) => state != null, // Global build condition
      listenerCondition: (state) => state != null, // Global listen condition
      child: EasyLocalization(
         supportedLocales: const[ Locale('en', 'US'), Locale('ta', 'IN')],
    path: 'assets/translations', // <-- change the path of the translation files 
    fallbackLocale: const Locale('en', 'US'),
    saveLocale: true,
    startLocale: const Locale('en', 'US') ,
        child: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return MaterialApp(
              home: LoginScreen() ,
              navigatorKey: navigatorKey,
              title: StringResource.APPBARTXT,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
               locale: context.locale,
              // supportedLocales: const [
              //   Locale('en'),
              // ],
              // routeInformationProvider:
              //     AppPages.router.routeInformationProvider,
              // routeInformationParser: AppPages.router.routeInformationParser,
              // routerDelegate: AppPages.router.routerDelegate,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    ),
  );
}


