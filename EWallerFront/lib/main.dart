
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:waletayty/screens/Login.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: LoginPage(),

      // home: Bottom(),
    //  home: Login(),
      //home: Add_Screen(),

      //home:  Home(),
    );
  }
}
