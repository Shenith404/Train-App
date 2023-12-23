import 'package:flutter/material.dart';
import 'package:trainapp/Widgets/Route.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Wrap(
        children: [
          route(
            image: "assets/avatar.jpg",
            RouteName: "Kandy to Galle",
            Members: 20,
          ),
          route(
            image: "assets/avatar.jpg",
            RouteName: "Kandy to Galle",
            Members: 20,
          ),
          route(
            image: "assets/avatar.jpg",
            RouteName: "Kandy to Galle",
            Members: 20,
          ),
          route(
            image: "assets/avatar.jpg",
            RouteName: "Kandy to Galle",
            Members: 20,
          ),
          route(
            image: "assets/avatar.jpg",
            RouteName: "Kandy to Galle",
            Members: 20,
          ),
          route(
            image: "assets/avatar.jpg",
            RouteName: "Kandy to Galle",
            Members: 20,
          ),
          route(
            image: "assets/avatar.jpg",
            RouteName: "Kandy to Galle",
            Members: 20,
          ),
          route(
            image: "assets/avatar.jpg",
            RouteName: "Kandy to Galle",
            Members: 20,
          ),
        ],
      ),
    );
  }
}
