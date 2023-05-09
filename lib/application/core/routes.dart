import 'package:flutter/material.dart';
import 'package:rent_car/Features/authentication/presentation/pages/login_screen.dart';
import 'package:rent_car/Features/authentication/presentation/pages/splash_screen.dart';
import '../../Features/home/presentation/pages/home_page_screen.dart';
import '../../Features/authentication/presentation/pages/onBoarding_screen.dart';
import '../../Features/authentication/presentation/pages/signUp_screen.dart';


class Routes {
  static const splash = '/';
  static const onBoarding = '/onBoarding';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';

  static Route routes(RouteSettings settings) {
    MaterialPageRoute _buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    }
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen());
      case onBoarding:
        return _buildRoute(const OnBoardingScreen());
      case login:
        return _buildRoute(const LoginProvider());
      case register:
        return _buildRoute(const SignUpProvider());
      case home:
        return _buildRoute(const HomePageScreen());
      default:
        throw Exception('Route does not exists');
    }
  }
}