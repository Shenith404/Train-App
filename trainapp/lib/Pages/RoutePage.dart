import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  Future<void>  delete (String routeID) async{

  /*await FirebaseFirestore.instance
      .collection('train_routes')
      .where('routeId', isEqualTo: routeID)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
  querySnapshot.docs.forEach((doc) {
  doc.reference.delete();
  });
  });*/
    await FirebaseFirestore.instance
    .collection('train_routes')
    .doc(routeID).delete();
  _loadTrainRoutes();


}
  @override
  Widget build(BuildContext context) {
    double screenWidth =MediaQuery.of(context).size.width;



    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        _showLogoutConfirmationDialog(context);
        // Return false to prevent default back button behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Padding(
            padding:  EdgeInsets.symmetric(horizontal:screenWidth*0.015),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(" Train Tracker Community",
                style: GoogleFonts.salsa(),),
                IconButton(onPressed: () {
                  _showLogoutConfirmationDialog(context);

                }, icon: Icon(Icons.logout))

              ],
            ),
          ),

         /* actions: [


            IconButton(onPressed: () {
              _showLogoutConfirmationDialog(context);

            }, icon: Icon(Icons.logout))
          ],*/
        ),
        body: Stack(
          children: [SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                Padding(
                    padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.07),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("All Routes",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),),
                          SizedBox(height: 15,),
                          Text(trainRoutesFiltered.length.toString() + " Routes Are Available"),
                        ],
                      ),
                    ],
                  ),
                ),

             Center(
               //show Train Routes

               child: Wrap(
                 children: <Widget>[
                   for (var route in trainRoutesFiltered)
                     RouteWidget(
                       date : DateTime.now().year.toString() +'/' +DateTime.now().month.toString()+'/'+DateTime.now().day.toString(),
                       image: "assets/train.jpg",
                       routeName: route.routeName,
                       userId: route.userId,
                       routeID: route.routeId,
                       delete: () async{
                         delete(route.routeId);
                       },
                     ),
                 ],
               ),
             ),
                          ],
                        ),
          ),
             searchBox(screenWidth),]
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

  Padding searchBox(double screenWidth) {
    return Padding(

      padding:  EdgeInsets.symmetric(horizontal:screenWidth*0.04,vertical: screenWidth*0.015),
      child: Container(

        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 236, 236),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0 ),
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
