import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui295/screens/cart_screen.dart';
import 'package:ui295/screens/imageview.dart';
import 'package:ui295/screens/optionscreen.dart';
class HomeScreen extends StatelessWidget {
  List a = [
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg",
    "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/08/09/21/54/yellowstone-national-park-1581879_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/07/11/15/43/pretty-woman-1509956_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/02/13/12/26/aurora-1197753_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
    "https://cdn.pixabay.com/photo/2013/11/28/10/03/autumn-219972_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg",
  ];
  List b=['Saqib','Ali','Atif','Umair','Uzair','Shahzaib','Mumtaz','Zohaib','Ahsan','Mohsin'];
  FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.green[300],
        title: Text('Home Screen',style:GoogleFonts.acme(color: Colors.white),),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.next_plan_outlined),

              )
        ],

      ),
      drawer: ClipRRect(

        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),topRight: Radius.circular(50)),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Muhammad Saqib',style: GoogleFonts.kalam(fontSize: 25),),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home,color: Colors.red,),
                  title: Text('Inbox'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),Divider(height: 2,),
                ListTile(
                  leading: Icon(Icons.settings_applications,color: Colors.red,),
                  title: Text('Email'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),Divider(height: 2,),
                ListTile(
                  leading: Icon(Icons.contact_phone,color: Colors.red,),
                  title: Text('Phone Number'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                Divider(height: 2,),
                ListTile(
                  leading: Icon(Icons.add_business_sharp,color: Colors.red,),
                  title: Text('Address'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                Divider(height: 2,),
                ListTile(
                  leading: Icon(Icons.add_business_sharp,color: Colors.red,),
                  title: Text('Logout'),
                  onTap: () {

                    _auth.signOut().then((value) =>
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => OptionScreen()),
                        )
                    );
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          )  ),
      backgroundColor: Colors.purple[100],
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: 10),
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,


              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: a.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                          image: new DecorationImage(
                            image: NetworkImage(a[index]),
                            fit: BoxFit.fill,
                          )
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Categories',style: GoogleFonts.aBeeZee(fontSize: 20),),
                  Text('See All',style: GoogleFonts.aBeeZee(fontSize: 20,color: Colors.blueAccent),),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.red[200],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)
                  )
              ),

              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: a.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ImageView(a[index],b[index])),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 160,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            image: new DecorationImage(
                              image: NetworkImage(a[index]),
                              fit: BoxFit.fill,
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(b[index],style: GoogleFonts.aclonica(color: Colors.white),),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
