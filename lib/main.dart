import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_test/add_notes.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1280, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context ,child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:HomePage(),
          );
        }
    );

  }
}
