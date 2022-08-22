import 'dart:io';

import 'package:ao_flutter_oauth2/ao_flutter_oauth2.dart';
import 'package:ao_flutter_oauth2/ao_flutter_oauth2_app.dart';
import 'package:ao_flutter_oauth2_example/app/architecture/base_view_model.dart';
import 'package:ao_flutter_oauth2_example/app/router/navigator_paramter.dart';

import '../../router/app_router.dart';
import '../../service/navigation_service.dart';

class LoginScreenViewModel extends BaseViewModel {
  late final NavigationService _navigateService;
  LoginScreenViewModel(NavigationService navigationService) {
    _navigateService = navigationService;
  }

  String _email = '';
  String _password = '';

  bool isAvailableAppleSignIn = false;

  void email(String email) {
    _email = email;
  }

  void password(String password) {
    _password = password;
  }

  Future<void> login() async {
    if (_email.isEmpty || _password.isEmpty) {
      dialogService.showAlert(message: 'Please input email and password!');
      return;
    }
    dialogService.showLoading();
    try {
      await FirebaseAuthencation().login(_email, _password);
      dialogService.hideLoading();
      final user = FirebaseAuthencation().checkCurrentUser();
      if (user != null) {
        final homeArg = HomeArgs(email: user.email, userName: user.displayName);
        _navigateService.pushNamed(AppRoute.home, args: homeArg);
      }
    } catch (error) {
      dialogService.hideLoading();
      dialogService.showAlert(message: error.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    dialogService.showLoading();
    try {
      final user = await FirebaseAuthencation().loginWithGoogle();
      dialogService.hideLoading();
      if (user != null) {
        final homeArg = HomeArgs(email: user.email, userName: user.displayName);
        _navigateService.pushNamed(AppRoute.home, args: homeArg);
      }
    } catch (error) {
      dialogService.hideLoading();
      dialogService.showAlert(message: error.toString());
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      final user = await FirebaseAuthencation().loginWithFacebook();
      dialogService.hideLoading();
      if (user != null) {
        final homeArg = HomeArgs(email: user.email, userName: user.displayName);
        _navigateService.pushNamed(AppRoute.home, args: homeArg);
      }
    } catch (error) {
      dialogService.hideLoading();
      dialogService.showAlert(message: error.toString());
    }
  }

  Future<void> loginWithApple() async {
    try {
      final user = await FirebaseAuthencation().loginWithApple();
      if (user != null) {
        final homeArg = HomeArgs(email: user.email, userName: user.displayName);
        _navigateService.pushNamed(AppRoute.home, args: homeArg);
      }
    } catch (error) {
      dialogService.hideLoading();
      dialogService.showAlert(message: error.toString());
    }
  }

  void gotoSignUpScreen() {
    _navigateService.pushNamed(AppRoute.signUpScreen);
  }

  Future<void> checkLoginAppleAvailable() async {
    if (Platform.isIOS) {
      isAvailableAppleSignIn =
          await FirebaseAuthencation().checkAppleSignInAvailable();
    } else {
      isAvailableAppleSignIn = false;
    }
    notifyListeners();
  }
}
