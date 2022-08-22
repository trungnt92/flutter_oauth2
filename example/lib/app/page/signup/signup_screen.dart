import 'package:ao_flutter_oauth2_example/app/page/signup/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../architecture/base_view.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBindingScope<SignUpViewModel>(
        onModelReady: (viewModel) {},
        builder: (context, viewModel, child) => Scaffold(
              body: _buildBody(viewModel),
            ));
  }

  Widget _buildBody(SignUpViewModel viewModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 60.h),
          const Text('Register Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 60.h),
          TextField(
            onChanged: (value) {
              viewModel.email(value);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 20.h),
          TextField(
            onChanged: (value) {
              viewModel.password(value);
            },
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 40.h),
          TextButton(
              onPressed: () {
                viewModel.signUp();
              },
              child: const Text('SignUp',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
          SizedBox(height: 20.h),
          TextButton(
              onPressed: () {
                viewModel.back();
              },
              child: const Text('Cancel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)))
        ]),
      ),
    );
  }
}
