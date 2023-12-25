import 'package:flutter/material.dart';
import 'package:trainapp/Entities/TrainRoute.dart';
import 'package:trainapp/Widgets/RouteWidget.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final list = TrainRoute.routeList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Train Routes'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            children: <Widget>[
              for (var li in list)
                RouteWidget(
                  Members: 10,
                  image: "assets/train.jpg",
                  routeName: li.routeName,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
