

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainapp/Wrapper.dart';

import '../Entities/AppUser.dart';

class AuthService  extends ChangeNotifier{
  //instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;




  //instance of firestore
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  // sign in with email
  Future signWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email
  Future registerWithEmailAndPassword(String email, String password) async {
    
    try {
      //register user as Authernticate user
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;

      //create user in database
      _firestore.collection("AppUsers").doc(result.user!.uid).set({
        'appUserId' :result.user!.uid,
        'email' :result.user!.email,
        'role' : "none"
      });
    } catch (e) {
      return null;
    }
  }

  //sign out
  Future<void> singOut() async{
    await _auth.signOut();
  }
}
