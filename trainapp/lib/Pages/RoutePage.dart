import 'package:flutter/material.dart';
import 'package:trainapp/Colours/Colors.dart';
import 'package:trainapp/Entities/TrainRoute.dart';
import 'package:trainapp/Widgets/RouteWidget.dart';
import 'package:trainapp/Wrapper.dart';

import '../Services/auth.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final list = TrainRoute.routeList();
  final _auth =AuthService();

  //confrim logout
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          title: const Text('Confirm Logout',style: TextStyle(color: secondaryColor),),
          content:const Text('Are you sure you want to log out?',style: TextStyle(color: secondaryColor)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel',style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                await _auth.singOut();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Wrapper())); // Close the dialog
                // Uncomment the line below if you want to navigate to a different screen after logout
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text('Logout',style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        _showLogoutConfirmationDialog(context);
        // Return false to prevent default back button behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(' Train Routes'),
          actions: [
            IconButton(onPressed: () {
              _showLogoutConfirmationDialog(context);

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
      ),
    );
  }
}
