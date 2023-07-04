import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:twsela/components/core_components.dart';
import 'package:twsela/modules/driver_modules/new_trip.dart';

import 'location_controller.dart';
import 'location_search_dialog.dart';

class MapScreens extends StatefulWidget {
  const MapScreens({Key? key}) : super(key: key);

  @override
  State<MapScreens> createState() => _MapScreensState();
}

class _MapScreensState extends State<MapScreens> {
  late CameraPosition _cameraPosition;
  @override
  void initState() {
    super.initState();
    _cameraPosition =
        CameraPosition(target: LatLng(30.033333, 31.233334), zoom: 17);
  }

  late GoogleMapController _mapController;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Location'),
              backgroundColor: Colors.green[700],
            ),
            body: Stack(
              children: <Widget>[
                GoogleMap(
                    onMapCreated: (GoogleMapController mapController) {
                      _mapController = mapController;
                    },
                    initialCameraPosition: _cameraPosition),
                Positioned(
                  top: 100,
                  left: 10,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Get.dialog(
                        LocationSearchDialog(mapController: _mapController)),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(children: [
                        Icon(Icons.location_on,
                            size: 25, color: Theme.of(context).primaryColor),
                        SizedBox(width: 5),
                        //here we show the address on the top
                        Expanded(
                          child: Text(
                            '${locationController.pickPlaceMark.name ?? ''}'
                            ' ${locationController.pickPlaceMark.locality ?? ''} '
                            '${locationController.pickPlaceMark.postalCode ?? ''}'
                            ' ${locationController.pickPlaceMark.country ?? ''}',
                            style: TextStyle(fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.search,
                            size: 25,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ]),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 26,
                  right: 60,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      fromChecker = false;
                      toChecker = false;
                    },
                    color: Colors.green,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }
}
