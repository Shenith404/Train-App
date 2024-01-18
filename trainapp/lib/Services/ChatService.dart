import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:trainapp/Entities/AppUser.dart';
import 'package:trainapp/Entities/Message%20.dart';
import 'package:trainapp/Services/auth.dart';


class ChatService extends ChangeNotifier {
  // Firebase auth instance
  FirebaseAuth _auth = FirebaseAuth.instance;
  // Firestore instance
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send Message
  Future<void> sendMessage(
      String routeName,
      String messageContent,
      String timeStamp,
      DateTime now,
      ) async {


    // Get current user info
    final String currentuserId = _auth.currentUser!.uid;
    final String currentuserEmail = _auth.currentUser!.email.toString();

    var newMessageId = now.toString() + now.millisecondsSinceEpoch.toString();
    AuthService authService =AuthService();
    AppUser ?user =await authService.getAppUser(_auth.currentUser!.uid);
    String userName = user!=null ? user.userName  : "AppUser";







    // Create a new message
    Message newMessage = Message(
      newMessageId,
      currentuserId,
      currentuserEmail,
    userName,
      timeStamp,
      messageContent,
    );

    // Add new message to the database
    await _firestore
        .collection("chatPages")
        .doc(routeName)
        .collection("Messages")
        .add(newMessage.toMap());
  }

  // Get messages
  Stream<QuerySnapshot> getMessages(String routeName) {
    return _firestore
        .collection("chatPages")
        .doc(routeName)
        .collection("Messages")
        .orderBy('messageId', descending: false)
        .snapshots();
  }


}
