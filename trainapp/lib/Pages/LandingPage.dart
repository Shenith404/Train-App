import 'package:flutter/material.dart';
import "package:trainapp/Colours/Colors.dart";
import 'package:trainapp/Pages/Auth/LoginOrRegister.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Image and Fade
          Stack(
            children: <Widget>[
              //Image
              const Image(
                image: AssetImage("assets/train.jpg"),
                fit: BoxFit.fill,
              ),

              //white Fader 01
              Container(
                height: 450,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                  ),
                ),
              ),

              //white Fader 02
              Container(
                height: 450,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(0),
                      Colors.white
                    ],
                  ),
                ),
              )
            ],
          ),

          const SizedBox(
            height: 30,
          ),

          //Text line one
          const Text(
            "This sequence truncates the visible text at the content area’s edge. ",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //Gray Text line
          const Text(
            "So, the truncation occurs in the mid-section of the character.",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: primaryColor,
            ),
          ),

          const SizedBox(
            height: 40,
          ),

          //Get Stated Button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginOrRegister()));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
              primary: primaryColor,
              onPrimary: const Color.fromARGB(255, 255, 255, 255),
            ),

            //Button Text
            child: const Text(
              "Get Started",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
