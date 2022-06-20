import 'package:flutter/material.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Profile"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.blue,
              child: Icon(Icons.perm_identity_rounded,color: Colors.white,),

            ),

          ),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(

              decoration: InputDecoration(
                hintText: 'enter your full name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
          ),
          TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
                backgroundColor: Colors.blue,

              ),
              onPressed: (){}, child: Text("submit",style: TextStyle(color:Colors.white),)),

        ],
      ),
    );
  }
}
