import 'package:ao_flutter_oauth2_example/app/architecture/base_view.dart';
import 'package:ao_flutter_oauth2_example/app/page/home/home_screen_view_model.dart';
import 'package:ao_flutter_oauth2_example/app/router/navigator_paramter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  late String? email;
  late String? name;

  HomeScreen(HomeArgs homeArgs) {
    email = homeArgs.email;
    name = homeArgs.userName;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBindingScope<HomeScreenViewModel>(
        onModelReady: (viewModel) {},
        builder: (context, viewModel, child) => Scaffold(
              body: _buildBody(viewModel),
            ));
  }

  Widget _buildBody(HomeScreenViewModel viewModel) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              const Text('Home',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 60.h),
              Text('Email: ${email ?? ''}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 20.h),
              Text('User Name: ${name ?? ''}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 40.h),
              TextButton(
                  onPressed: () {
                    viewModel.signOut();
                  },
                  child: const Text('SignOut',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700))),
            ],
          )),
    );
  }
}
