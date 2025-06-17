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

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/name-input',
      builder: (context, state) => const NameInputScreen(),
    ),
    GoRoute(
      path: '/email-auth',
      builder: (context, state) {
        final username = state.extra as String?;
        return EmailAuthScreen(username: username ?? '');
      },
    ),
    GoRoute(
      path: '/password-create',
      builder: (context, state) {
        final extra = state.extra as Map<String, String>?;
        return PasswordCreateScreen(
          username: extra?['username'] ?? '',
          email: extra?['email'] ?? '',
        );
      },
    ),
    GoRoute(
      path: '/find-school',
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
      path: '/main-capital',
      builder: (context, state) => const MainCapitalScreen(),
    ),
    GoRoute(
      path: '/monthly-revenue',
      builder: (context, state) => const MonthlyRevenueScreen(),
    ),
    GoRoute(
      path: '/order-detail',
      builder: (context, state) => const OrderDetailScreen(),
    ),
  ],
);
