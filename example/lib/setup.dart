import 'package:ao_flutter_oauth2_example/app/page/home/home_screen_view_model.dart';
import 'package:ao_flutter_oauth2_example/app/page/login/login_view_model.dart';
import 'package:ao_flutter_oauth2_example/app/page/signup/signup_view_model.dart';
import 'package:ao_flutter_oauth2_example/app/page/splash_screen/splash_screen_view_model.dart';
import 'package:get_it/get_it.dart';

import 'app/service/dialog_service.dart';
import 'app/service/navigation_service.dart';

/// Ioc instance
GetIt locator = GetIt.instance;

/// Setup dependencies in application
Future setupLocator() async {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  // Services
  locator.registerLazySingleton<DialogService>(() => DialogServiceImpl());

  _setupDataSource();

  _setupUseCases();

  _setupViewModel();
}

/// Respositories and Data sources
void _setupDataSource() {
  // locator.registerFactory<GamesDataSource>(() => LocalGamesDataSourceImpl());
  // locator.registerLazySingleton<GamesRespository>(
  //     () => GamesRepositoryImpl(locator()));
}

/// Register all use cases in IoC
void _setupUseCases() {
  // locator.registerFactory(() => FetchGamesUseCase(locator()));
}

/// Register all bloc in IoC
void _setupViewModel() {
  // locator.registerFactory<FirstScreenBloc>(
  //     () => FirstScreenBloc(ListGameState(listGame: []), locator(), locator()));
  locator.registerSingleton(SplashScreenViewModel(locator()));
  locator.registerSingleton(LoginScreenViewModel(locator()));
  locator.registerSingleton(SignUpViewModel(locator()));
  locator.registerSingleton(HomeScreenViewModel(locator()));
}
