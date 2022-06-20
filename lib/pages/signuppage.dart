import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui295/models/user_modal.dart';
import 'package:ui295/pages/loginpage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();
    if (email == "" || password == "" || cPassword == "") {
      print('enter all details');
    } else {
      print('you enter all details sucessfully ');
      signUp(email, password);
    }
  }

  void signUp(String email, String password) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("new user created");
    } on FirebaseAuthException catch (ex) {
      print(ex.code.toString());
    }
    if (credential != null) {
      String uid = credential.user!.uid;
      UserModel newUser = UserModel(
        uid: uid,
        email: email,
        fullname: "",
        profilepic: "",
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then((value) => print('new user created saqib'))

          .whenComplete(() =>
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          ));
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
              Text(
                'Chat App',
                style: GoogleFonts.acme(fontSize: 30, color: Colors.blue),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'email', hintText: "enter e mail"),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'password', hintText: "enter password"),
              ),
              TextFormField(
                controller: cPasswordController,
                decoration: InputDecoration(
                  labelText: 'confirm password',
                  hintText: "confirm password",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    checkValues();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => CompleteProfile()),
                    // );
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    "Signin",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "dalready have an account",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
