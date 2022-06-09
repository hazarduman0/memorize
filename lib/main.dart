import 'package:flutter/material.dart';
import 'package:memorize/constants/appColors.dart';
import 'package:memorize/view/mainPage.dart';
import 'package:memorize/view/sildirme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Memorize',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // navigationBarTheme: NavigationBarThemeData(
        //   backgroundColor: AppColors.UIColor,
        // ),
        primarySwatch: Colors.blue,   
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0.0,
          centerTitle: true,
        ),
        backgroundColor: AppColors.backgroundColor,
    
      ),
      home: MainPage(),
    );
  }
}

