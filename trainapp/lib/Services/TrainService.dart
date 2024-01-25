import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class TrainService extends ChangeNotifier{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _routesCollection = FirebaseFirestore.instance.collection('train_routes');

  Future<void> addTrainRoute(String routeId, String routeName) async {
    await _routesCollection.doc(routeId).set({
      'routeId': routeId,
      'routeName': routeName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'chatList': [], // You may customize this based on your requirements
      'trainList': [],
    });
  }

  Stream<QuerySnapshot> getTrainRoutes() {
    return _routesCollection.snapshots();
  }
  
  //Add Members to collection
  Future<void> addMembers(String uId,String routeId) async{
    
    await FirebaseFirestore.instance
        .collection("train_routes")
        .doc(routeId).collection("Members")// Use the UID as the document ID
        .add({
      // You can add more fields as needed
      'userId': uId,
      // Add other fields if necessary
    });

  }


}
