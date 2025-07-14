import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jusicool_ios/core/config/widget/menu_bottom.dart';
import 'package:jusicool_ios/presentation/community/screens/community_post_list_screen.dart';
import 'package:jusicool_ios/presentation/my_capital/screens/maincapital_screen.dart';
import 'package:jusicool_ios/presentation/my_capital/screens/my_assets_screen.dart';
import 'package:jusicool_ios/presentation/my_capital/screens/order_screens/order_detail_screen.dart';
import 'package:jusicool_ios/presentation/my_capital/screens/revenue_screens/monthlyrevenue_screen.dart';
import 'package:jusicool_ios/presentation/sign_in/screens/login_screen.dart';
import 'package:jusicool_ios/presentation/sign_up/screens/email_auth_screen.dart';
import 'package:jusicool_ios/presentation/sign_up/screens/find_school_screen.dart';
import 'package:jusicool_ios/presentation/sign_up/screens/name_input_screen.dart';
import 'package:jusicool_ios/presentation/sign_up/screens/password_create_screen.dart';
import 'package:jusicool_ios/presentation/splash/screens/splash_screen.dart';
import 'package:jusicool_ios/presentation/news/screens/news_list_screen.dart';

class RoutePaths {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signUp = '/sign_up';
  static const String main = '/';
  static const String nameInput = '/name-input';
  static const String emailAuth = '/email-auth';
  static const String passwordCreate = '/password-create';
  static const String findSchool = '/find-school';
  static const String mainCapital = '/main-capital';
  static const String monthlyRevenue = '/monthly-revenue';
  static const String orderDetail = '/order-detail';
  static const String myAssets = '/my-assets';
  static const String communityPostList = '/community-post-list';
}

class AppRouter {
  AppRouter._internal();

  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() => _instance;

  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.nameInput,
        builder: (context, state) => const NameInputScreen(),
      ),
      GoRoute(
        path: RoutePaths.emailAuth,
        builder: (context, state) => const EmailAuthScreen(),
      ),
      GoRoute(
        path: RoutePaths.passwordCreate,
        builder: (context, state) => const PasswordCreateScreen(),
      ),
      GoRoute(
        path: RoutePaths.findSchool,
        builder: (context, state) => const FindSchoolScreen(),
      ),
      GoRoute(
        path: RoutePaths.monthlyRevenue,
        builder: (context, state) => const MonthlyRevenueScreen(),
      ),
      GoRoute(
        path: RoutePaths.orderDetail,
        builder: (context, state) => const OrderDetailScreen(),
      ),
      GoRoute(
        path: RoutePaths.myAssets,
        builder: (context, state) => const MyAssetsScreen(),
      ),
      GoRoute(
        path: RoutePaths.communityPostList,
        builder: (context, state) => const CommunityPostListScreen(),
      ),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MenuBottom(child: child);
        },
        routes: [
          GoRoute(
            path: RoutePaths.mainCapital,
            builder: (context, state) => const MainCapitalScreen(),
          ),
          GoRoute(
            path: '/chart',
            builder: (context, state) => const MainCapitalScreen(),
          ),
          GoRoute(
            path: '/news-list',
            builder: (context, state) => const NewsListScreen(),
          ),
          GoRoute(
            path: '/mypage',
            builder: (context, state) => const MyAssetsScreen(),
          ),
        ],
      ),
    ],
  );
}
