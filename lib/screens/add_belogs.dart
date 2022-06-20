// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:ui295/components/helper.dart';
//
// class AddBlogs extends StatelessWidget {
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _priceController = TextEditingController();
//   TextEditingController _descriptionController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     getUserID();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Product"),
//       ),
//       body: Column(
//         children: [
//           TextFormField(
//             controller: _nameController,
//             decoration: InputDecoration(labelText: "Product Name"),
//           ),
//           TextFormField(
//             controller: _priceController,
//             decoration: InputDecoration(labelText: "Product Price"),
//           ),
//           TextFormField(
//             controller: _descriptionController,
//             decoration: InputDecoration(labelText: "Product Description"),
//           ),
//           TextButton(
//             onPressed: () {
//               print('product ad/..................................');
//               FirebaseFirestore.instance.collection('productData').add({
//                 'productName': _nameController.text,
//                 'productPrice': _priceController.text,
//                 'productDescription': _descriptionController.text,
//                 'uid': getUserID()
//
//               });
//               print('product ad/..................................');
//
//
//             },
//             child: Text("Add Product"),
//           ),
//         ],
//       ),
//     );
//   }
// }
//





import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ui295/components/helper.dart';
import 'package:ui295/components/round_button.dart';
import 'package:ui295/screens/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBlogs extends StatefulWidget {
  @override
  State<AddBlogs> createState() => _AddBlogsState();
}

class _AddBlogsState extends State<AddBlogs> {
  File? _image;
  String title = '', description = '';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _DescriptionController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;


  final postRef = FirebaseFirestore.instance.collection('Products');
  // final postDet = FirebaseDatabase.instance.ref().child('All data');


  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    dialog(context);
                  },
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: _image != null
                          ? ClipRect(
                              child: Image.file(
                                _image!.absolute,
                                height: 130,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg')),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.blue,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 5,
                        onChanged: (value) {
                          title = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Title',
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _DescriptionController,
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 5,
                        onChanged: (value) {
                          description = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Description',
                          labelText: 'Enter your Description',
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      RoundButton(
                          title: 'Add',
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              print("validated...................................................");
                              setState(() {
                                showSpinner = true;
                                print("spinner true..........................................");
                              });
                              try {
                                int date =
                                    DateTime.now().microsecondsSinceEpoch;
                                firebase_storage.Reference ref =
                                    firebase_storage.FirebaseStorage.instance
                                        .ref('/blogapp$date');
                                UploadTask uploadTask =
                                    ref.putFile(_image!.absolute);
                                await Future.value(uploadTask);
                                var newUrl = await ref.getDownloadURL();
                                print(newUrl);
                                print("..................................................");


                                final User? user = _auth.currentUser;
                                postRef
                                    .add({
                                      'pId': date.toString(),
                                      'pImage': newUrl.toString(),
                                      'pTime': date.toString(),
                                      'pTitle':
                                          _titleController.text.toString(),
                                      'pdescription': _DescriptionController
                                          .text
                                          .toString(),
                                      'pEmail': user!.email.toString(),
                                       'uid': getUserID()

                                    })
                                    .whenComplete(() => Navigator.pop(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                        ))
                                    .then((value) {
                                      toastMessage('post published');
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    })
                                    .onError((error, stackTrace) {
                                      toastMessage(error.toString());
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    });
                              } catch (e) {
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            }
                          }),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getCameraImage();
                    },
                    child: ListTile(
                      leading: Icon(Icons.add_a_photo),
                      title: Text('Camera'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGalary();
                    },
                    child: ListTile(
                      leading: Icon(Icons.photo_library_outlined),
                      title: Text('Galary'),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  final piker = ImagePicker();

  Future getImageGalary() async {
    final pickedFile = await piker.pickImage(source: ImageSource.gallery);
    print('image selected');

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.pop(context);
        print('image setState selected');
      } else {
        print('no image selected');
      }
    });
  }

  Future getCameraImage() async {
    final pickedFile = await piker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image selected');
      }
    });
  }

  void toastMessage(String Message) {
    Fluttertoast.showToast(
        msg: Message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
