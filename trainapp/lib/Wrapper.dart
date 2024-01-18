import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trainapp/Pages/EditUserName.dart';
import 'package:trainapp/Pages/LandingPage.dart';
import 'package:trainapp/Pages/RoutePage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<AppUser>(context);

    // if (user == null) {
    //   return LandingPage();
    // } else {
    //   return RoutePage();
    // }
    //  return LandingPage();
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            // User is signed in
            if (snapshot.data != null) {
              // If the user just logged in, show EditUserName
              return EditUserName();
            } else {
              // If the user was already logged in, show RoutePage
              return RoutePage();
            }
          } else {
            // User is not signed in
            return LandingPage();
          }
        },
      ),
    );
  }
}
