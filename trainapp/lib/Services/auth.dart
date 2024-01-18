

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainapp/Wrapper.dart';

import '../Entities/AppUser.dart';

class AuthService  extends ChangeNotifier{
  //instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future getAppUser(String id) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("AppUsers")
          .doc(id)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          debugPrint(userData.toString());
          AppUser user= AppUser(userData['appUserId'], userData['email'], userData['userName'], userData['role']);
          return user;


        } else {
          return null;
        }
      }
    } catch (error) {
      print('Error retrieving user: $error');
    }



  }



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

      return e.toString();
    }
  }

  //Update UserName
  Future<void> updateUserName(String uid, String newUserName) async {
    try {

      await _firestore.collection('AppUsers').doc(uid).update({
        'userName': newUserName,
      });
    } catch (error) {
      print("Error updating userName in Firestore: $error");
      throw error;
    }
  }

  //register with email
  Future registerWithEmailAndPassword(String email, String password) async {
    
    try {
      //register user as Authernticate user
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //create user in database
      _firestore.collection("AppUsers").doc(result.user!.uid).set({
        'appUserId' :result.user!.uid,
        'email' :result.user!.email,
        'userName':" ",
        'role' : "none"
      });
      return result.user;


    } catch (e) {
      return e.toString();
    }
  }

  //sign out
  Future<void> singOut() async{
    await _auth.signOut();
  }
}
