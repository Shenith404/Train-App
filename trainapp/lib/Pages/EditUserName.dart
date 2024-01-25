import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:trainapp/Colours/Colors.dart";
import 'package:trainapp/Pages/Auth/LoginOrRegister.dart';
import 'package:trainapp/Pages/RoutePage.dart';
import 'package:trainapp/Services/auth.dart';

import '../Entities/AppUser.dart';

class EditUserName extends StatefulWidget {
  const EditUserName({Key? key});

  @override
  State<EditUserName> createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  TextEditingController userNameController=TextEditingController();
  AuthService authService=AuthService();

  @override
  void initState() {
    initializeUser();
  }

  void initializeUser() async{

    AppUser ?user =await authService.getAppUser(FirebaseAuth.instance.currentUser!.uid);
    userNameController.text =  user!=null ? user.userName:"AppUser";
  }
  void updateUserName() async{
    await authService.updateUserName(FirebaseAuth.instance.currentUser!.uid, userNameController.text);

  }


  @override
  Widget build(BuildContext context) {
    double Height=MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
                    SizedBox(height: Height * 0.7),
        
                    Center(
                      child: FadeInDown(
                        from: 20,
                        child:  Text(
                          "Train Tracker Community",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style:GoogleFonts.salsa(
                            fontSize: 40
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Height * 0.1),  // 10% of screen height
        
                    // Second Row: Change your name
                    const Text(
                      "Change your name",
                      style: TextStyle(fontSize: 18, color: primaryColor),
                    ),
        
                    SizedBox(height: Height * 0.02),  // 2% of screen height
        
        
                    // Fourth Row: Name Entering Box
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: TextField(
                        controller: userNameController,
                        decoration: InputDecoration(hintText: "Add The name"),
                      ),
                    ),
        
                    SizedBox(height: Height * 0.08),
        
                    // Fifth Row: Continue Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {
                       if(!userNameController.text.isEmpty){
                         updateUserName();
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoutePage()));
                       }
                      },
                      child: const Text("Next",style: TextStyle(color: secondaryColor),),
                    ),
                  ],
        
                )
              ],
            ),
        
        
          ],
        ),
      ),
    );
  }
}
