import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui295/screens/homescreen.dart';

import '../components/helper.dart';

class DisplayProducts extends StatefulWidget {
  @override
  _DisplayProductsState createState() => _DisplayProductsState();
}

class _DisplayProductsState extends State<DisplayProducts> {
  List <DocumentSnapshot> Products = [];
  CollectionReference postRef=FirebaseFirestore.instance.collection("Products");

  ///function definition
  getProducts() {
    FirebaseFirestore.instance
        .collection('productData')
        .where('uid', isEqualTo: getUserID())
        .get()
        .then((value) => value.docs.map((product) {
      Products.add(product);
      setState(() {});
    }).toList());
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display Products"),
      ),
      body: Column(
        children: [
          FutureBuilder<dynamic>(
            ///Stream: Stream is basically a point in db from where we are gettin data
            future: FirebaseFirestore.instance
                .collection('Products')
                .where('uid', isEqualTo: getUserID())
                .get(),
            builder: (context, snapshot) {
              ///We have to put validation to check if our snapshot has data
              ///In other we will display circular  progress indicator
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      print(i);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),


                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              title: Text(
                                  snapshot.data.docs[i].data()['pTitle']),
                              subtitle: Text(
                                  "email: \$${snapshot.data.docs[i].data()['pEmail']}"),
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(

                                    image: NetworkImage(
                                        snapshot.data.docs[i].data()['pImage']
                                    ),
                                    fit: BoxFit.cover,

                                  ),



                                ),

                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // IconButton(
                                  //   icon: Icon(
                                  //     Icons.edit,
                                  //     color: Colors.blue,
                                  //   ),
                                  //   onPressed: () {
                                  //     ///For update product we have to pass product data along with product id to update product screen
                                  //     Navigator.pushReplacement(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) => UpdateProduct(
                                  //               productID: snapshot.data.docs[i].id,
                                  //
                                  //               productName: snapshot.data.docs[i].data()['productName'],
                                  //               productDescription: snapshot.data.docs[i].data()['productDescription'],
                                  //               productPrice: snapshot.data.docs[i].data()['productPrice'],
                                  //             )));
                                  //   },
                                  // ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      deleteProduct(snapshot.data.docs[i].id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                      );

                    });
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),








    );
  }
  deleteProduct(String productID) {

    FirebaseFirestore.instance
        .collection('productData')
        .doc(productID)
        .delete()
        .whenComplete(() {
          print("delete sucessfully");

    });
  }
}