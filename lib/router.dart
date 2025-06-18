import 'package:go_router/go_router.dart';
import 'package:jusicool_ios/screens/signup_screens/name_input_screen.dart';
import 'package:jusicool_ios/screens/signup_screens/email_auth_screen.dart';
import 'package:jusicool_ios/screens/signup_screens/password_create_screen.dart';
import 'package:jusicool_ios/screens/signup_screens/find_school_screen.dart';
import 'package:jusicool_ios/screens/login_screen.dart';
import 'package:jusicool_ios/screens/splash_screen.dart';
import 'package:jusicool_ios/screens/mycapital_screens/maincapital_screen.dart';
import 'package:jusicool_ios/screens/mycapital_screens/monthlyrevenue_screen.dart';
import 'package:jusicool_ios/screens/mycapital_screens/order_detail.dart';

class RoutePaths {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String nameInput = '/name-input';
  static const String emailAuth = '/email-auth';
  static const String passwordCreate = '/password-create';
  static const String findSchool = '/find-school';
  static const String mainCapital = '/main-capital';
  static const String monthlyRevenue = '/monthly-revenue';
  static const String orderDetail = '/order-detail';
}

class AppRouter {
  AppRouter._internal();
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;

  late final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.nameInput,
        builder: (context, state) => const NameInputScreen(),
      ),
      GoRoute(
        path: RoutePaths.emailAuth,
        builder: (context, state) {
          final username = state.extra as String?;
          return EmailAuthScreen(username: username ?? '');
        },
      ),
      GoRoute(
        path: RoutePaths.passwordCreate,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>?;
          return PasswordCreateScreen(
            username: extra?['username'] ?? '',
            email: extra?['email'] ?? '',
          );
        },
      ),
      GoRoute(
        path: RoutePaths.findSchool,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>?;
          return FindSchoolScreen(
            username: extra?['username'] ?? '',
            email: extra?['email'] ?? '',
            password: extra?['password'] ?? '',
          );
        },
      ),
      GoRoute(
        path: RoutePaths.mainCapital,
        builder: (context, state) => const MainCapitalScreen(),
      ),
      GoRoute(
        path: RoutePaths.monthlyRevenue,
        builder: (context, state) => const MonthlyRevenueScreen(),
      ),
      GoRoute(
        path: RoutePaths.orderDetail,
        builder: (context, state) => const OrderDetailScreen(),
      ),
    ],
  );
}
