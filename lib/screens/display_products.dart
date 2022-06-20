// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../components/helper.dart';
//
// class DisplayProducts extends StatefulWidget {
//   @override
//   _DisplayProductsState createState() => _DisplayProductsState();
// }
//
// class _DisplayProductsState extends State<DisplayProducts> {
//   List <DocumentSnapshot> Products = [];
//
//   ///function definition
//   getProducts() {
//     FirebaseFirestore.instance
//         .collection('productData')
//         .where('uid', isEqualTo: getUserID())
//         .get()
//         .then((value) => value.docs.map((product) {
//       Products.add(product);
//       setState(() {});
//     }).toList());
//   }
//
//   @override
//   void initState() {
//     getProducts();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Display Products"),
//       ),
//       body: Products.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//           itemCount: Products.length,
//           itemBuilder: (context, i) {
//             return
//
//               Card(
//               child: ListTile(
//                 isThreeLine: true,
//                 title: Text(Products[i].data()['productName']),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Text(Products[i].data()['productPrice']),
//                     Text(Products[i].data()['productDescription'])
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }