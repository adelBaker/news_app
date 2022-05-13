import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app2/view/login.dart';
import 'package:news_app2/view/login.dart';
import 'package:news_app2/view/news_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Login(),

      debugShowCheckedModeBanner:false,
    );
  }
}
