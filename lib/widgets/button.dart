import 'package:flutter/material.dart';
class Button extends StatelessWidget {

  late  String name;
  Button({required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          style: TextButton.styleFrom(

            padding: EdgeInsets.symmetric(horizontal: 150,vertical: 20),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
            onPressed: null, child: Text(name)),
      ),
    );
  }
}
