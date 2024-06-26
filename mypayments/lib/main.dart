import 'package:flutter/material.dart';
import 'package:mypayments/pages/home/home_page.dart';
import 'package:mypayments/pages/login/login_page.dart';
import 'package:mypayments/utils/service_locator.dart';

void main() {
  ServiceLocator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPayments',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      // TODO: When release, set LoginPage instead of Home
      home: const String.fromEnvironment('useTestData') == 'true'
          ? const HomePage()
          : const LoginPage(),
    );
  }
}
