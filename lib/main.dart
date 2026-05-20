import 'package:covid_19_tracker/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Tracker',
     
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: Color(0xffFECEE9),
        )
      ),
        // backgroundColor: Color(0xffFECEE9),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        
      ),

      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}