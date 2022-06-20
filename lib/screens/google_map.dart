import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMAp extends StatefulWidget {





  @override
  State<GoogleMAp> createState() => _GoogleMApState();
}

class _GoogleMApState extends State<GoogleMAp> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.768051, 72.360703),
    zoom: 14.4746,
  );


  List<Marker> _marker=[];
  List<Marker> _list=const[
    Marker(markerId: MarkerId('1'),
      position:LatLng(33.857616, 72.393265),
      infoWindow: InfoWindow(
        title: 'kamra house',
      )
    ),
    Marker(markerId: MarkerId('2'),
      position:LatLng(38.52796133580664, -122.485749655962),
        infoWindow: InfoWindow(
          title: 'Attock house',
        )),
    Marker(markerId: MarkerId('3'),
      position:LatLng(33.768051, 72.360703),
        infoWindow: InfoWindow(
          title: 'Attock house',
        )),
  ];
  @override
  void initState(){
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
             
            },
            icon: Icon(Icons.next_plan_outlined),

          )
        ],
      ),

      body: GoogleMap(
        initialCameraPosition:_kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: false,
        compassEnabled: false,
        markers:Set<Marker>.of(_marker) ,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          GoogleMapController controller= await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(38.52796133580664, -122.485749655962)
            ,zoom: 14)
          ));
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
