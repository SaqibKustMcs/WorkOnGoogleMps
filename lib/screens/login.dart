import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:ui295/screens/homescreen.dart';
import 'package:ui295/screens/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    setState(() {});
  }

  makeLoadingFalse() {
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children:[
                Padding(
                  padding: const EdgeInsets.only(left:20,top: 60),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Welcome,",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 31),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20,top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Sign in to continue!,",

                      style: TextStyle(fontSize: 27,color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),

                Padding(
                  padding: const EdgeInsets.only(left:18.0,right: 18),
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    decoration: InputDecoration(
                        labelText: "Email Id",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:18.0,right: 18),
                  child: TextField(
                    controller:  _pwdController,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    obscureText: true,
                    decoration: InputDecoration(


                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: new BorderSide(color: Colors.teal)
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right:12.0,top: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text("Forgot password?",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),

                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.orange
                    ),
                    onPressed: () {
                      _loginUser(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => UserDashBoard()));
                    },

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 148,vertical: 10),
                      child: Text("Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // style: ButtonStyle(
                    //   backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff4325c)),
                    // ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),


                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),

                  ),
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange
                    ),
                    onPressed: () {},
                    icon: Icon(

                      Icons.motorcycle_outlined,
                      color: Colors.white,
                    ),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 10),
                      child: Text(
                        "Connect With facebook",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // style: ButtonStyle(
                    //   backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff4325c)),
                    // ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("I'm a new user"),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
                      },
                      child: Text("Sign Up",
                        style: TextStyle(color: Color(0xfff4325c),fontWeight: FontWeight.bold),
                      ),

                    )
                  ],

                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
  _loginUser(BuildContext context) async {
    makeLoadingTrue();
    try {
      ///This will allow user to register in firebase
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailController.text, password: _pwdController.text)
          .whenComplete(() => makeLoadingFalse())
          .then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Message!'),
              content: Text("LoggedIn successfully"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
              ],
            );
          },
        );
      });
      ;
    } on FirebaseAuthException catch (e) {
      makeLoadingFalse();
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('ALert!'),
            content: Text('check'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
            ],
          );
        },
      );
    }
  }
}