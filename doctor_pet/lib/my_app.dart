import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:doctor_pet/core/services/repo_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/services/app_services.dart';
import 'core/theme/app_theme.dart';
import 'language/language.dart';
import 'utils/app_config.dart';
import 'utils/app_constant.dart';
import 'utils/app_enum.dart';
import 'utils/app_routes.dart';

Future<void> runMyApp() async {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black.withOpacity(.5)
    ..backgroundColor = Colors.black.withOpacity(.5)
    ..indicatorColor = Colors.white;
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  const String apiBaseUrl =
      'https://e7bc-2402-800-63b5-c431-c413-51a5-106f-ea71.ngrok-free.app';

  Get.put<AppEnvironment>(
    AppEnvironment.live(
      apiBaseUrl: apiBaseUrl,
    ),
  );
  await AppServices.initServices();
  await RepoServices.initServices();

  bool isAuth = await Get.find<LocalAuthRepo>().checkAuth();
  bool isCustomer = Get.find<LocalAuthRepo>().getRole() == Role.customer;
  runApp(
    GetMaterialApp(
      scrollBehavior: AppScrollBehavior(),
      title: StringConstant.appName,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale(LocaleKey.vi, CountryKey.vn),
        Locale(LocaleKey.en, CountryKey.en),
      ],
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      initialRoute: isAuth
          ? isCustomer
              ? RoutesName.customerHome
              : RoutesName.home
          : RoutesName.login,
      getPages: AppRoutes.mainRoutes,
      theme: AppThemes.lightTheme,
      translations: Language(),
      builder: EasyLoading.init(
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    ),
  );
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
