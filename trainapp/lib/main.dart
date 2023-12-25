import "package:flutter/material.dart";
import "package:trainapp/Pages/ChatPage.dart";

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatPage(
        routeName: "Kandy to Galle",
        routeImage: "assets/train.jpg",
        members: 20,
      ),
    );
  }
}
