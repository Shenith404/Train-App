import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:trainapp/Entities/Message%20.dart';

class ChatService extends ChangeNotifier{
  //firebase auths instnce
  FirebaseAuth _auth =FirebaseAuth.instance;
  //firestore instance
  FirebaseFirestore _firestore =FirebaseFirestore.instance;



  //Send Message
  Future<void> sendMessage(
      String routeName,
      String messageContent,
      String timeStamp,
      String createdDate,

      ) async{

    //get current user infor
     final String currentuserId =_auth.currentUser!.uid;
     final String currentuserEmail = _auth.currentUser!.email.toString();

     //create new user
    Message newMessage = Message(
    createdDate
        ,currentuserId,
        currentuserEmail,
        timeStamp,
        messageContent);
    //Add new message to database
    await _firestore.collection("chatPages")
     .doc(routeName)
     .collection("Messages")
     .add(newMessage.toMap());

  }
  //Get message
  Stream<QuerySnapshot> getMessages(String routeName) {
    return  _firestore.collection("chatPages")
        .doc(routeName)
        .collection("Messages")
        .orderBy('messageId',descending:false).snapshots();
  }

}