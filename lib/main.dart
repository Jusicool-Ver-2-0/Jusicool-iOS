import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_ios/core/config/di/dependencies.dart';
import 'package:jusicool_ios/menu_bottom.dart';
import 'package:jusicool_ios/router.dart';

import 'core/config/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setDio();
  di.allReady();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: JusicoolColor.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: JusicoolColor.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationParser: AppRouter.router.routeInformationParser,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          theme: appTheme,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuBottom();
  }
}
