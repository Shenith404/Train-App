import 'package:flutter/material.dart';
import 'package:trainapp/Entities/TrainRoute.dart';
import 'package:trainapp/Widgets/RouteWidget.dart';

import '../Services/auth.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final list = TrainRoute.routeList();
  final _auth =AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Train Routes'),
        actions: [
          IconButton(onPressed: () async{
            await _auth.singOut();
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          //show Train Routes

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
