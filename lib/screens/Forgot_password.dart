import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui295/components/round_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool showSpinner = true;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 40,),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                // onChanged: (value) {
                //   email = value;
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your Email',

                    // focusColor: Colors.white,
                    hoverColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                    )),
              ),
              SizedBox(height: 50,),
              RoundButton(
                  title: 'Forgot Password',
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                         _auth.sendPasswordResetEmail(
                            email: _emailController.text.toString())
                            .then((value) {
                          setState(() {
                            showSpinner = false;
                          });
                          toastMessage('check your email');
                         })

                    .onError((error, stackTrace){
                    toastMessage(error.toString());
                    setState(() {
                    showSpinner = false;
                    });});


                    } catch (e) {
                    toastMessage(e.toString());
                    setState(() {
                    showSpinner = false;
                    });
                    };
                  }
                  }),

            ],
          ),
        ),
      ),
    );
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
