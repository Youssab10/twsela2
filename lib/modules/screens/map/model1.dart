import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrawLineData {
  // late List<LatLng> list;
  List<LatLng> listOfPoints = [];
  DrawLineData .fromJson(Map<String, dynamic> json){
    final list = json['features'][0]["geometry"]['coordinates'] as List;

    list.forEach((element) {
      listOfPoints.add(LatLng(element[1], element[0]));
    });
  }
}