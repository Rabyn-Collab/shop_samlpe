import 'package:fireapp/location/map_show.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


class LocationCheck extends StatelessWidget {
Position? position;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Center(
          child: ElevatedButton(
              onPressed: () async{
                LocationPermission locationPermission = await Geolocator.requestPermission();

                if(locationPermission == LocationPermission.denied){
                  await Geolocator.requestPermission();
                }else if(locationPermission == LocationPermission.deniedForever){
                  await Geolocator.openAppSettings();
                }else if(locationPermission == LocationPermission.always || locationPermission == LocationPermission.whileInUse){
                  position = await Geolocator.getCurrentPosition();
                    if(position != null){
                      // List<Placemark> placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
                      // print(placemarks);
                      Get.to(() => MapSample(position!.latitude, position!.longitude));
                    }

                }


          }, child: Text('Location')),
        )
    );
  }
}
