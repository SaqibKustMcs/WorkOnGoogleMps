import 'dart:async';
// import 'dart:html';


import 'package:flutter/material.dart';
import 'package:ui295/screens/homescreen.dart';
import 'package:ui295/screens/optionscreen.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=> Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OptionScreen()),
            )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://cdn.pixabay.com/photo/2016/07/11/15/43/pretty-woman-1509956_960_720.jpg')
                ),

              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,

                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}
