import 'package:ao_flutter_oauth2_example/app/architecture/base_view.dart';
import 'package:ao_flutter_oauth2_example/app/page/splash_screen/splash_screen_view_model.dart';
import 'package:ao_flutter_oauth2_example/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulBindingScope<SplashScreenViewModel>(
        onModelReady: (viewModel) {
          viewModel.initSplashScreen();
        },
        builder: (context, viewModel, child) => Scaffold(
              body: _buildBody(),
            ));
  }

  Widget _buildBody() {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Images.avatar,
                width: 300.w, height: 200.h, fit: BoxFit.contain),
            SizedBox(height: 20.h),
            const Text('tranthienhau',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
          ]),
    );
  }
}
