import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Canes App ',
      theme: ThemeData(


        primaryColor: AppColors.amberCanes,



      ),
      home: Login(),
    );
  }
}

