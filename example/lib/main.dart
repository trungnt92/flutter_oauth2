import 'package:ao_flutter_oauth2/ao_flutter_oauth2_app.dart';
import 'package:ao_flutter_oauth2_example/setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/router/app_router.dart';
import 'app/service/navigation_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // sets up the internal locator
  await setupLocator();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    await FirebaseAuthencation().initFirebase();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   await FirebaseAuthencation().initFirebase();

  //   // try {
  //   //   await FirebaseAuthencation()
  //   //       .createAccount('dat.uit.k6@gmail.com', '123456');
  //   // } catch (error) {
  //   //   print('Error create account : ${error.toString()}');
  //   // }

  //   try {
  //     final user = await FirebaseAuthencation().loginWithGoogle();
  //     if (user != null) {
  //       print('${user.displayName}');
  //     }
  //   } catch (error) {
  //     print('Error login google : ${error.toString()}');
  //   }

  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion =
  //         await AoFlutterOauth2.platformVersion ?? 'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: ((context, child) {
          return MaterialApp(
            title: 'Demo App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: AppRoute.generateRoute,
            initialRoute: AppRoute.splashScreen,
            navigatorKey: globalNavigationKey,
            builder: EasyLoading.init(),
          );
        }));
  }
}
