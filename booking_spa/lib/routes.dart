import 'package:flutter/material.dart';

import 'screens/change_password/change_password_screen.dart';
import 'screens/detail/detail_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/register/register_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/welcome/welcome_screen.dart';

class Routes {
  Routes._();
  // login
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  // home
  static const String home = '/';
  static const String detail = '/detail';
  static const String search = '/search';

  // profile
  static const String profile = '/profile';
  static const String changePassword = '/changePassword';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => const SplashScreen(),
    welcome: (BuildContext context) => const WelcomeScreen(),
    login: (BuildContext context) => const LoginScreen(),
    register: (BuildContext context) => const RegisterScreen(),
    profile: (BuildContext context) => const ProfileScreen(),
    changePassword: (BuildContext context) => const ChangePasswordScreen(),
    home: (BuildContext context) => const HomeScreen(),
    detail: (BuildContext context) => const DetailScreen(),
    search: (BuildContext context) => const SearchScreen(),
  };
}
