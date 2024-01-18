import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trainapp/Colours/Colors.dart';
import 'package:trainapp/Entities/TrainRoute.dart';
import 'package:trainapp/Widgets/RouteWidget.dart';
import 'package:trainapp/Wrapper.dart';

import '../Services/TrainService.dart';
import '../Services/auth.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final trainService = TrainService();
  final _auth =AuthService();
  List<TrainRoute> trainRoutes = [];
  List<TrainRoute> trainRoutesFiltered = [];



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
  void initState() {
    super.initState();
    _loadTrainRoutes();
  }

  Future<void> _loadTrainRoutes() async {
    List<TrainRoute> routes = await TrainRoute.getTrainRoutes();
    setState(() {
      trainRoutes = routes;
      debugPrint(trainRoutes.toString());
      trainRoutesFiltered= trainRoutes;
    });
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
          child: Column(
            children: [
              searchBox(),
              Center(
                //show Train Routes

                child: Wrap(
                  children: <Widget>[
                    for (var route in trainRoutesFiltered)
                      RouteWidget(
                        Members: route.trainList.length,
                        image: "assets/train.jpg",
                        routeName: route.routeName,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //Add route
        floatingActionButton: FloatingActionButton(

          onPressed: () {
            _showAddRouteDialog(context);
            _loadTrainRoutes();
          },
          backgroundColor: primaryColor,

          child:const Icon(Icons.add,color: secondaryColor,),
        ),
      ),
    );
  }

  void _showAddRouteDialog(BuildContext context) {
    String routeName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Route'),
          content: TextField(
            onChanged: (value) {
              routeName = value;
            },
            decoration: InputDecoration(labelText: 'Route Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (routeName.isNotEmpty) {
                  await TrainRoute.addTrainRoute(
                    TrainRoute(
                      DateTime.now().toString(), // You might want to generate a unique routeId
                      routeName,
                      FirebaseAuth.instance.currentUser!.uid,
                      [], // Initial chat list
                      [], // Initial train list
                    ),
                  );
                  Navigator.pop(context);
                  await _loadTrainRoutes(); // Reload train routes
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  //search box
  void _runSearch(String key) {
    List<TrainRoute> result  = [];
    if (key.isEmpty) {
      result = trainRoutes;
    } else {
      result = trainRoutes
          .where((item) =>
          item.routeName!.toLowerCase().contains(key.toLowerCase()))
          .toList();
    }
    setState(() {
      trainRoutesFiltered = result;
    });
  }

  Padding searchBox() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 236, 236),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0 ,vertical: 4),
          child: TextField(
            onChanged: (value) => _runSearch(value),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: primaryColor,
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 20,
                  maxWidth: 20,
                ),
                border: InputBorder.none,
                hintText: "Search"),
          ),
        ),
      ),
    );
  }
}
