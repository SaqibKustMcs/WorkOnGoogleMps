import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageView extends StatelessWidget {
  final String image;
  final String name;
  ImageView(this.image,this.name ) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image View',style: GoogleFonts.aBeeZee(),),
        centerTitle: true,

      ),
      backgroundColor: Colors.black12,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text(name,style: GoogleFonts.abel(color: Colors.white,fontSize: 22),),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image)
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
