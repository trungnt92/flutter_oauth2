import 'package:ao_flutter_oauth2/ao_flutter_oauth2_app.dart';
import 'package:ao_flutter_oauth2_example/app/architecture/base_view_model.dart';
import 'package:ao_flutter_oauth2_example/app/router/app_router.dart';

import '../../service/navigation_service.dart';

class HomeScreenViewModel extends BaseViewModel {
  late final NavigationService _navigateService;
  HomeScreenViewModel(NavigationService navigationService) {
    _navigateService = navigationService;
  }

  Future<void> signOut() async {
    dialogService.showLoading();
    FirebaseAuthencation().logout();
    dialogService.hideLoading();

    _navigateService.pushNamedAndRemoveUntil(AppRoute.loginScreen);
  }
}
