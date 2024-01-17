import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import "package:trainapp/Colours/Colors.dart";
import 'package:trainapp/Pages/Auth/LoginOrRegister.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    double Height=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Image and Fade
          Stack(
            children: <Widget>[
              //Image

              Image(
                image: AssetImage("assets/mobileWallpaper.png"),
                fit: BoxFit.cover,
                width:MediaQuery.of(context).size.width ,

              ),

              //white Fader 01
              Container(
                height: MediaQuery.of(context).size.width*504/453,
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
                height: MediaQuery.of(context).size.width*504/453,
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
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width,
                  ),
                  Center(
                    child: FadeInDown(
                      from: 20,
                      child: const Text(
                        "Train App ",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),

           SizedBox(
            height: MediaQuery.of(context).size.height/15,
          ),

          //Text line one
          FadeInUp(
            from: 50,
            child: const Text(
              "This sequence truncates the visible text at the content area’s edge. ",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height/40,
          ),

          //Gray Text line
          FadeInUp(
            from: 60,
             child: Text(
              "So, the truncation occurs in the mid-section of the character.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: primaryColor,
              ),
                       ),
           ),

          SizedBox(
            height: MediaQuery.of(context).size.height/20,
          ),

          //Get Stated Button
          FadeInUp(
            from: 70,
            child: ElevatedButton(
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
          ),
        ],
      ),
    );
  }
}
