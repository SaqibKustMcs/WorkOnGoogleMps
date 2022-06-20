import 'package:flutter/material.dart';
import 'package:ui295/components/round_button.dart';
import 'package:ui295/screens/register.dart';
import 'package:google_fonts/google_fonts.dart';


import 'login.dart';

class OptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 150,
                backgroundColor: Colors.white,
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2013/11/28/10/03/autumn-219972_960_720.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              RoundButton(
                  title: 'Login',

                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }),
              RoundButton(
                  title: 'Register',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
