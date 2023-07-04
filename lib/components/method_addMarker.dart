import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twsela/modules/driver_modules/driver_map_screen.dart';
import '../../modules/passenger_pages/map_screen.dart';

addMarker(String id, LatLng location) async {
  //var markerImage = (await BitmapDescriptor.fromAssetImage(
    //  const ImageConfiguration(), 'assets/images/person.jpg'));
  //var url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQInz-6l1XE1IP1MaoPCgS6ZBBLVeyMMgfxnlygg4eoEg&s';
  // var bytes =  (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
  var marker = Marker(
    markerId: MarkerId(id),
    position: location,

 //   icon: markerImage,
  );
  MapScreen.markers[id] = marker;
  DriverMapScreen.driverMarkers[id] = marker;
}
