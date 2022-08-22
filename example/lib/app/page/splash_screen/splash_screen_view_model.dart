import 'package:ao_flutter_oauth2_example/app/architecture/base_view_model.dart';
import 'package:ao_flutter_oauth2_example/app/router/app_router.dart';

import '../../service/navigation_service.dart';

class SplashScreenViewModel extends BaseViewModel {
  late final NavigationService _navigateService;

  SplashScreenViewModel(NavigationService navigationService) {
    _navigateService = navigationService;
  }

  void initSplashScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      _navigateService.pushNamed(AppRoute.loginScreen);
    });
  }
}
