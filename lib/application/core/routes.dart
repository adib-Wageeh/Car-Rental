import 'package:flutter/material.dart';
import 'package:rent_car/Features/authentication/presentation/pages/login_screen.dart';
import 'package:rent_car/Features/authentication/presentation/pages/reset_password_screen.dart';
import 'package:rent_car/Features/authentication/presentation/pages/splash_screen.dart';
import '../../Features/authentication/presentation/pages/authenticate_email_screen.dart';
import '../../Features/home/presentation/pages/edit_account_screen.dart';
import '../../Features/home/presentation/pages/home_page_screen.dart';
import '../../Features/authentication/presentation/pages/onBoarding_screen.dart';
import '../../Features/authentication/presentation/pages/signUp_screen.dart';


class Routes {
  static const splash = '/';
  static const onBoarding = '/onBoarding';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const reset = '/reset';
  static const unVerified = '/unVerified';
  static const editAccount = '/editAccount';


  static Route routes(RouteSettings settings) {
    PageRouteBuilder buildRoute(Widget widget) {
      return PageRouteBuilder(pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return widget;
      },
        transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),

      );
    }
    switch (settings.name) {
      case splash:
        return buildRoute(const SplashScreen());
      case onBoarding:
        return buildRoute(const OnBoarding());
      case login:
        return buildRoute(const LoginProvider());
      case register:
        return buildRoute(const SignUpScreen());
      case home:
        return buildRoute(const HomePageScreen());
      case reset:
        return buildRoute(const ResetPasswordProvider());
      case unVerified:
        return buildRoute(const AuthenticateEmailScreen());
      case editAccount:
        return buildRoute(const EditAccountScreenProvider());
      default:
        throw Exception('Route does not exists');
    }
  }
}
