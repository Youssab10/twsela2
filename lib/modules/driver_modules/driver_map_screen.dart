import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twsela/components/default_app_bar.dart';

import '../../components/method_addMarker.dart';

const LatLng currentLocation = LatLng(30.033333, 31.233334);

class DriverMapScreen extends StatelessWidget {
  DriverMapScreen({Key? key}) : super(key: key);
  late GoogleMapController myDriverController;
  static Map<String, Marker> driverMarkers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        leadingFunction: () {},
        title: 'Map',
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: currentLocation,
          zoom: 12,
        ),
        onMapCreated: (controller) {
          myDriverController = controller;
          addMarker('test', currentLocation);
        },
        markers: driverMarkers.values.toSet(),
      ),
    );
  }
}
