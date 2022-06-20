import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui295/models/user_modal.dart';
import 'package:ui295/pages/completeprofile.dart';
import 'package:ui295/pages/signuppage.dart';
import 'package:ui295/screens/homescreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email == "" || password == "") {
      print('please fill all the fields');
    } else {
      print('you enter all details sucessfully ');
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(credential);
    } on FirebaseAuthException catch (ex) {
      print(ex.code.toString());
    }
    if (credential != null) {
      String uid = credential.user!.uid;
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection(
          'users').doc(uid).get().whenComplete(() =>
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          ));
      UserModel userModel = UserModel.fromMap(
          userData.data() as Map<String, dynamic>);
      print('Login successful');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB9C157FF),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Chat App',
                style: GoogleFonts.acme(fontSize: 30, color: Colors.blue),),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "email"
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "password",

                ),
              ),
              SizedBox(height: 30,),
              TextButton(
                  onPressed: checkValues,


                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("login", style: TextStyle(color: Colors.white),)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "don't have an acount", style: TextStyle(color: Colors.white),),
            SizedBox(width: 10,),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: Text('Signup', style: TextStyle(color: Colors.white),)),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
