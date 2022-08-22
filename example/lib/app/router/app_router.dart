import 'package:ao_flutter_oauth2_example/app/page/home/home_screen.dart';
import 'package:ao_flutter_oauth2_example/app/page/login/login_screen.dart';
import 'package:ao_flutter_oauth2_example/app/page/signup/signup_screen.dart';
import 'package:ao_flutter_oauth2_example/app/page/splash_screen/splash_screen.dart';
import 'package:ao_flutter_oauth2_example/app/router/navigator_paramter.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
/// Manage all routes in the application
class AppRoute {
  /// Splash Page route
  static const splashScreen = '/splashPage';

  /// Login Page route
  static const loginScreen = '/loginPage';

  /// Signup Page route
  static const signUpScreen = '/signUpPage';

  /// Home Page route
  static const home = '/home';

  /// App router generation
  static Route<Object>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case home:
        final arg = settings.arguments as HomeArgs;
        return MaterialPageRoute(builder: (_) => HomeScreen(arg));
      default:
        break;
    }
  }
}
