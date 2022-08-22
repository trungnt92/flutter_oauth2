import 'package:ao_flutter_oauth2/ao_flutter_oauth2_app.dart';
import 'package:ao_flutter_oauth2_example/app/architecture/base_view_model.dart';
import 'package:ao_flutter_oauth2_example/app/router/navigator_paramter.dart';

import '../../router/app_router.dart';
import '../../service/navigation_service.dart';

class SignUpViewModel extends BaseViewModel {
  late final NavigationService _navigateService;
  SignUpViewModel(NavigationService navigationService) {
    _navigateService = navigationService;
  }

  String _email = '';
  String _password = '';

  void email(String email) {
    _email = email;
  }

  void password(String password) {
    _password = password;
  }

  Future<void> signUp() async {
    if (_email.isEmpty || _password.isEmpty) {
      dialogService.showAlert(message: 'Please input email and password!');
      return;
    }
    dialogService.showLoading();
    try {
      await FirebaseAuthencation().createAccount(_email, _password);
      dialogService.hideLoading();
      final user = FirebaseAuthencation().checkCurrentUser();
      if (user != null) {
        final homeArg = HomeArgs(email: user.email, userName: user.displayName);
        _navigateService.pushNamed(AppRoute.home, args: homeArg);
      } else {
        _navigateService.goBack();
      }
    } catch (error) {
      dialogService.hideLoading();
      dialogService.showAlert(message: error.toString());
    }
  }

  void back() {
    _navigateService.goBack();
  }
}
