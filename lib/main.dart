// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:audit_app_admin/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'mainmenu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

const String SERVER_URL = "https://eu-api.backendless.com";
const String APPLICATION_ID = "B4767E6C-1CFB-2E7D-FF6D-8E06E61C3900";
const String ANDROID_API_KEY = "37EE5605-1A6E-45FE-B475-90CAFBB5D2A1";
const String IOS_API_KEY = "868DBCE3-EAE9-436E-AD67-557A5ADF44C7";
const String JS_API_KEY = "11EFD95E-1E59-4853-8E0F-D3A0ADEED12D";

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    init();
  }

  void init() async {
    await Backendless.initApp(
      applicationId: APPLICATION_ID,
      androidApiKey: ANDROID_API_KEY,
      iosApiKey: IOS_API_KEY,
      jsApiKey: JS_API_KEY,
    );
    await Backendless.setUrl(SERVER_URL);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: child,
          debugShowCheckedModeBanner: false,
        );
      },
      child: const LoginPage(),
    );
  }
}
