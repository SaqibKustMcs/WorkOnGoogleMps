import 'dart:ffi';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  RoundButton({required this.title,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(onPressed: onPress,
          color: Colors.orange,
          minWidth: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(title,style:GoogleFonts.asul(fontSize: 18,color: Colors.white),),
          ),

        ),
      ),

    );
  }
}
