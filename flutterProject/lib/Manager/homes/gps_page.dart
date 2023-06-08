import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';


class GPSPage extends StatefulWidget {
  const GPSPage({Key? key}) : super(key: key);

  @override
  _GPSPageState createState() => _GPSPageState();
}

class _GPSPageState extends State<GPSPage> {
  Completer<GoogleMapController>? _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = Completer<GoogleMapController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS Page'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController!.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _moveToLocation();
        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }

  Future<void> _moveToLocation() async {
    final controller = await _mapController!.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(37.43296265331129, -122.08832357078792),
          zoom: 17,
        ),
      ),
    );
  }
}
