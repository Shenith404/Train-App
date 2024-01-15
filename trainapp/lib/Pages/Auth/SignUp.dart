import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/Colours/Colors.dart';
import 'package:trainapp/Services/auth.dart';

class signUp extends StatefulWidget {
  final void Function()? changePage;
  const signUp({
    super.key,
    required this.changePage,
  });

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
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

                    child: const Image(
                      image: AssetImage("assets/train.jpg"),
                      fit: BoxFit.fill,

                    ),
                  ),

                  //white Fader 01
                  Container(
                    height: 450,
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
                    height: MediaQuery.of(context).size.height,
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

                  SIgnUpItems(
                    changePage: widget.changePage,
                  )
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
  bool obcureText1 = true;
  bool obcureText2 = true;
  bool showIcon = true;

  //controlles
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conformPasswordController = TextEditingController();

  void singUpFunction() async {
    final _auth = Provider.of<AuthService>(context,listen: false);
    try {
      await _auth.registerWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            //Avatar
            SizedBox(
              height: MediaQuery.of(context).size.width / 2.75,
            ),

            CircleAvatar(
              backgroundImage: const AssetImage("assets/avatar.jpg"),
              radius: MediaQuery.of(context).size.width / 5.5,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.width / 15,
            ),

            // email
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              controller: emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 3, color: primaryColor)),
                labelText: 'Enter your Email',
                hintText: 'e.g., john_doe@gmail.com', // Add a hint text
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 30,
            ),
            // password
            TextFormField(
              controller: passwordController,
              obscureText: obcureText2,
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

            SizedBox(
              height: MediaQuery.of(context).size.width / 30,
            ),

            // confrom password
            TextFormField(
              controller: conformPasswordController,
              obscureText: obcureText2,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 3, color: primaryColor),
                ),
                labelText: 'Enter your Confirm Password',
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

            SizedBox(
              height: MediaQuery.of(context).size.width / 15,
            ),
            // Register Button
            ElevatedButton(
              onPressed: singUpFunction,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 108),
                primary: primaryColor,
                onPrimary: const Color.fromARGB(255, 255, 255, 255),
              ),

              //Button Text
              child: const Text(
                "Register",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.width / 30,
            ),
            //google

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                  onPressed: widget.changePage,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 35),
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
                        "  Continue with Google",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
            ),

            const SizedBox(
              height: 15,
            ),
            //change to signUp
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Alrady a Member ? "),
                GestureDetector(
                  onTap: widget.changePage,
                  child: const Text(
                    "Sign in Now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
