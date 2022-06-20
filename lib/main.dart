import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ui295/pages/loginpage.dart';
import 'package:ui295/screens/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: LoginPage(),
debugShowCheckedModeBanner: false,



    );
  }
}
