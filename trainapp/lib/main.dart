import "package:flutter/material.dart";
import "package:trainapp/Pages/Auth/LoginOrRegister.dart";
import "package:trainapp/Pages/RoutePage.dart";


void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: RoutePage());
  }
}
