
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twsela/components/default_app_bar.dart';

import '../../components/method_addMarker.dart';


const LatLng currentLocation = LatLng(30.033333, 31.233334);

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);
  late GoogleMapController myController ;
  static Map<String, Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        leadingFunction: (){},
        title: 'Map',
      ),
      body:  GoogleMap(
        initialCameraPosition: const CameraPosition(
            target: currentLocation,
            zoom: 12,

          ),
      onMapCreated: (controller)
      {
        myController = controller;
        addMarker('test' , currentLocation);
      },
        markers: markers.values.toSet(),
      ),

    );
  }



}
