import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scanner/models/scan_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    ScanModel scan = ModalRoute.of(context)?.settings.arguments as ScanModel;
    LatLng latLng = scan.getLatLng();
    double zoom = 14.4746;
    double tilt = 50;

    Set<Marker> markers = {};
    markers.add(Marker(
      markerId: const MarkerId('geo-location'),
      position: latLng,
    ));

    CameraPosition initialPoint = CameraPosition(
      target: latLng,
      zoom: zoom,
      tilt: tilt,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: () {
              setState(() {
                if (mapType == MapType.normal) {
                  mapType = MapType.satellite;
                } else {
                  mapType = MapType.normal;
                }
              });
            },
          )
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        zoomControlsEnabled: false,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.location_searching),
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: latLng,
                zoom: zoom,
                tilt: tilt,
              ),
            ),
          );
        },
      ),
    );
  }
}
