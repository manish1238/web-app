import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/screens/home_page.dart';
import 'constants/strings_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: AppStringConstants.appTitle,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      home: HomePage(),
    );
  }
}
