import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../layout/cubit/app_cubit.dart';
import 'model.dart';
import 'model1.dart';

class MyMap extends StatefulWidget {
  MyMap({
    Key? key,
  }) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late Position cl;
  late double x, y;
  late StreamSubscription<Position> positionStream;
  Future getPostion() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {}
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
      if (per == LocationPermission.always) {
        getLatLong();
      }
    }
  }

  Future<Position> getLatLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    setState(() {});
    return cl;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPostion();
    polylines;

    positionStream =
        Geolocator.getPositionStream().listen((Position? position) {
      changeMarker(position!.latitude, position.longitude);
      x = position.latitude;
      y = position.longitude;
    });
  }

  final completer = Completer<GoogleMapController>();
  static const CameraPosition cairo = CameraPosition(
    target: LatLng(30.0596113, 31.3408666),
    zoom: 8,
  );
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  changeMarker(lat, long) {
    markers.remove(Marker(markerId: MarkerId("Location")));
    markers.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        markerId: MarkerId("Location"),
        position: LatLng(lat, long)));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: cubit.fromController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'From',
                prefixIcon: Icon(
                  Icons.location_pin,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search"),
            onFieldSubmitted: (value) async {
              final resp = await Dio().get(
                  "https://api.openrouteservice.org/geocode/search?api_key=5b3ce3597851110001cf6248f3dacb8768e34a17a5f94cf6d01a1277&text=$value&boundary.country=EG&size=360");
              final model = SearchData.fromJson(resp.data);
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(16, 195, 16, 0),
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 25,
                  maxWidth: MediaQuery.of(context).size.width - 25,
                  maxHeight: 400,
                  minHeight: 200,
                ),
                items: List.generate(
                  model.results.length,
                  (index) => PopupMenuItem(
                    child: Text(model.results[index].name),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                ),
              );
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Location';
              } else {
                return null;
              }
            },
          ),
          GoogleMap(
            polylines: polylines,
            markers: markers,
            onTap: (argument) {
              markers.add(Marker(
                  markerId: MarkerId(argument.longitude.toString()),
                  position: LatLng(argument.latitude.toDouble(),
                      argument.longitude.toDouble())));
              setState(() {});
            },
            mapType: MapType.normal,
            initialCameraPosition: cairo,
            onMapCreated: (GoogleMapController controller) {
              completer.complete(controller);
            },
          ),
        ],
      ),
    );
  }

  goTo(double lat, double lng) async {
    final GoogleMapController controller = await completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 16)));
  }

  late LatLng previousPosition;

  s(num fromLong, num fromLat, num toLong, num toLat) async {
    final dis = await Dio().get(
        "https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248f3dacb8768e34a17a5f94cf6d01a1277&start=${fromLong},${fromLat}&end=${toLong},${toLat}");

    final model1 = DrawLineData.fromJson(dis.data);
    polylines.clear();
    polylines.add(Polyline(
        polylineId: PolylineId("ds"),
        color: Colors.blueAccent,
        width: 10,
        points: model1.listOfPoints));
  }
}
