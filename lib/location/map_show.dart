import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final double lat;
  final double long;
  MapSample(this.lat, this.long);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

Set<Marker> marker = {};

void _onCreate(){
  setState(() {
    marker.add(Marker(
        markerId: MarkerId('1'),
      position: LatLng(widget.lat, widget.long),
      infoWindow: InfoWindow(
        snippet: 'MindRiser',
        title: 'MindRiser'
      )
    ));
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: marker,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.long),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _onCreate();
        },
      ),

    );
  }


}