import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindjot/const/colors.dart';
import 'package:mindjot/pages/homepage.dart';
import 'package:mindjot/pages/login_page.dart';
import 'package:mindjot/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindJot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: turquoiseColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
