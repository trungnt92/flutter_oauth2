import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import '../widgets/loading_indicator/circle_indicator.dart';
import 'navigation_service.dart';

/// Dialog service interface
abstract class DialogService {
  /// Show a loading dialog on the current page
  Future showLoading({String? message});

  /// Hide a current loading dialog on the current page
  void hideLoading();

  Future showAlert({required String message});
}

/// Implementation of [DialogService]
class DialogServiceImpl implements DialogService {
  /// Create new instance for dialog service
  DialogServiceImpl();

  @override
  void hideLoading() {
    EasyLoading.dismiss();
  }

  @override
  Future showLoading({String? message}) async {
    EasyLoading.show(status: message ?? 'Loading...');
  }

  @override
  Future<void> showAlert({required String message}) async {
    final currentContext = globalNavigationKey.currentContext;
    if (currentContext != null) {
      await showDialog(
          context: currentContext,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
                content: Text(message),
              ));
    }
  }
}
