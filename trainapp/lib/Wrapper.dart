import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          if (snapshot.hasData) {
            return RoutePage();
          } else {
            return LandingPage();
          }
        },
      ),
    );
  }
}
