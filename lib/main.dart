import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_ios/screens/splash_screen.dart';
import 'package:jusicool_ios/screens/mycapital_screens/maincapital_screen.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget content;

  const BaseScreen({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Column(
          children: [Center(child: content), SizedBox(height: 52.h)],
        ),
      ),
    );
  }
}

class ScreenConfig {
  final String title;
  final Widget widget;

  ScreenConfig({required this.title, required this.widget});
}

class ScreenList {
  static final List<ScreenConfig> configs = [
    ScreenConfig(title: '자산', widget: const MainCapitalScreen()),
    ScreenConfig(
      title: '차트',
      widget: const BaseScreen(
        title: '차트 화면',
        content: Text('차트 화면입니다.', style: TextStyle(fontSize: 24)),
      ),
    ),
    ScreenConfig(
      title: '뉴스',
      widget: const BaseScreen(
        title: '뉴스 화면',
        content: Text('뉴스 화면입니다.', style: TextStyle(fontSize: 24)),
      ),
    ),
    ScreenConfig(
      title: '마이 페이지',
      widget: const BaseScreen(
        title: '마이 페이지',
        content: Text('마이 페이지입니다.', style: TextStyle(fontSize: 24)),
      ),
    ),
  ];

  static Widget getScreen(int index) {
    if (index < 0 || index >= configs.length) {
      return configs[0].widget;
    }
    return configs[index].widget;
  }

  static String getTitle(int index) {
    if (index < 0 || index >= configs.length) {
      return configs[0].title;
    }
    return configs[index].title;
  }
}

class NavBarItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.imagePath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 24.w,
            height: 24.h,
            color: isSelected ? AppColor.main : AppColor.gray400,
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'navi',
              fontWeight: FontWeight.w600,
              fontSize: 8.sp,
              color: isSelected ? AppColor.main : AppColor.gray400,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 52.h,
      color: AppColor.white,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: 360.w,
              height: 1.h,
              color: AppColor.gray100,
            ),
          ),
          Positioned(
            left: 42.w,
            top: 9.h,
            child: Container(
              width: 277.w,
              height: 36.2.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  ScreenList.configs.length,
                  (index) => NavBarItem(
                    imagePath: 'assets/images/${_getImageName(index)}.png',
                    label: ScreenList.getTitle(index),
                    isSelected: selectedIndex == index,
                    onTap: () => onTap(index),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getImageName(int index) {
    switch (index) {
      case 0:
        return 'capital';
      case 1:
        return 'chart';
      case 2:
        return 'news';
      case 3:
        return 'account';
      default:
        return 'capital';
    }
  }
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        top: false,
        bottom: true,
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            IndexedStack(
              index: selectedIndex,
              children: List.generate(
                ScreenList.configs.length,
                (index) => ScreenList.getScreen(index),
              ),
            ),
            Positioned(
              bottom: 0,
              child: BottomNavBar(selectedIndex: selectedIndex, onTap: onTap),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppNavigator();
  }
}

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColor.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColor.white,
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
        return MaterialApp(
          title: 'Jusicool',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppColor.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: AppColor.white,
              elevation: 0,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
