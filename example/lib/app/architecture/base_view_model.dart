import 'package:ao_flutter_oauth2_example/app/service/dialog_service.dart';
import 'package:ao_flutter_oauth2_example/setup.dart';
import 'package:flutter/foundation.dart';

abstract class BaseViewModel extends ChangeNotifier {
  late DialogService dialogService;
  BaseViewModel() {
    dialogService = locator.get<DialogService>();
  }
}
