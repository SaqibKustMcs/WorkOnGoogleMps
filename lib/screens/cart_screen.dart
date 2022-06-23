import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui295/components/helper.dart';
import 'package:ui295/screens/add_belogs.dart';
import 'package:ui295/screens/display_products.dart';
import 'package:ui295/screens/firebase_products.dart';
import 'package:ui295/screens/google_map.dart';
import 'package:ui295/screens/homescreen.dart';

class CartScreen extends StatefulWidget {


  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final postRef = FirebaseFirestore.instance.collection('Products');





  @override
  Widget build(BuildContext context) {
    CollectionReference user=FirebaseFirestore.instance.collection('users');
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart Screen'),
          bottom: TabBar(
            tabs: [
              Tab( text: "first",)
              ,Tab(text: "second",),
              Tab(text: "third",),
              Tab(text: "fourth",)
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBlogs()),
                );
              },
              icon: Icon(Icons.add_box_outlined),

            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoogleMAp()),
                );
              },
              icon: Icon(Icons.next_plan_outlined),

            ),

          ],

        ),
        body: TabBarView(
          children: [
            AddBlogs(),
            HomeScreen(),
            GoogleMAp(),
            DisplayProducts(),



          ],
        ),


    ),

    );
  }
}

