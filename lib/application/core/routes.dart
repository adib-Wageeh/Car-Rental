import 'package:flutter/material.dart';
import 'package:rent_car/Features/authentication/presentation/pages/login_screen.dart';
import 'package:rent_car/Features/authentication/presentation/pages/reset_password_screen.dart';
import 'package:rent_car/Features/authentication/presentation/pages/splash_screen.dart';
import '../../Features/authentication/presentation/pages/authenticate_email_screen.dart';
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

  static Route routes(RouteSettings settings) {
    MaterialPageRoute buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    }
    switch (settings.name) {
      case splash:
        return buildRoute(const SplashScreen());
      case onBoarding:
        return buildRoute(const OnBoardingScreen());
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
      default:
        throw Exception('Route does not exists');
    }
  }
}