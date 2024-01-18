import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/Colours/Colors.dart';
import 'package:trainapp/Services/auth.dart';
import 'package:trainapp/Widgets/Alert.dart';

import '../../Wrapper.dart';

class Signin extends StatefulWidget {
  final void Function()? changePage;
  Signin({super.key, required this.changePage});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Image and Fade
            Center(
              child: Stack(
                children: <Widget>[
                  //Image
                  Container(

                    child:  Image(
                      width:MediaQuery.of(context).size.width ,
                      image: AssetImage("assets/mobileWallpaper.png"),
                      fit: BoxFit.fill,


                    ),
                  ),

                  //white Fader 01
                  Container(
                    height: MediaQuery.of(context).size.width*504/453,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
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
                        begin: const Alignment(0.00, -1.00),
                        end: const Alignment(0, 1),
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

                    ],
                  ),

                  SIgnUpItems(
                    changePage: widget.changePage,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

//SignUp Items

class SIgnUpItems extends StatefulWidget {
  final void Function()? changePage;

  const SIgnUpItems({
    super.key,
    this.changePage,
  });

  @override
  State<SIgnUpItems> createState() => _SIgnUpItemsState();
}

class _SIgnUpItemsState extends State<SIgnUpItems> {
  final _formKey = GlobalKey<FormState>();
  bool obcureText1 = true;
  bool obcureText2 = true;
  bool showIcon = true;
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();

  //Error Message
  String ?messsage="";
  @override
  Widget build(BuildContext context) {




    //sign in
    AuthService _auth = Provider.of<AuthService>(context,listen: false);
    void signIn () async{
       dynamic user = await _auth.signWithEmail(emailController.text, passwordController.text);
       if(user.runtimeType==User){
         Navigator.of(context).push(
           MaterialPageRoute(
             builder: (context) => Wrapper(),
           ),
         );
       }else  {
         //show Error message
         showDialog(context: context,
             builder: (context)=>Alert(Title: "Try Again",Message: user.toString()));
       }
    }


    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //Avatar
              SizedBox(
                height: MediaQuery.of(context).size.width / 2.5,
              ),

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

              SizedBox(
                height: MediaQuery.of(context).size.width / 12,
              ),

              // email
              FadeInUp(
                from: 50,
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Plese Enter the Email";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 3, color: primaryColor)),
                    labelText: 'Enter your Email',
                    hintText: 'e.g., john_doe@gmail.com', // Add a hint text
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 30,
              ),

              // password
              FadeInUp(
                from: 60,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: obcureText2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Plese Enter the Password";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 3, color: primaryColor),
                    ),
                    labelText: 'Enter your Password',
                    hintText: 'Abc@123',
                    prefixIcon: IconButton(
                      icon: showIcon
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          obcureText2 = !obcureText2;
                          showIcon = !showIcon;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Text(messsage.toString(),style:TextStyle(color: Colors.red),),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.width / 30,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.width / 15,
              ),

            /*  // Register Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signIn();
                    }
                  },
                  style: ElevatedButton.styleFrom(

                    primary: primaryColor,
                    onPrimary: const Color.fromARGB(255, 255, 255, 255),
                  ),

                  //Button Text
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
*/
              FadeInUp(
                from: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signIn();
                      }
                    },
                    style: ElevatedButton.styleFrom(

                      primary: primaryColor,
                      onPrimary: const Color.fromARGB(255, 255, 255, 255),
                    ),

                    //Button Text
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          " Sign in",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              SizedBox(
                height: MediaQuery.of(context).size.width / 30,
              ),

              //google
              FadeInUp(
                from: 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(

                    ),

                    //Button Text
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/google.png"),
                          width: 20,
                        ),
                        Text(
                          " Google",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              //change to signUp
              FadeInUp(
                from: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a Member ?"),
                    GestureDetector(
                      onTap: widget.changePage,
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
