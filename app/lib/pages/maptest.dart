import 'package:app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDisplay extends StatefulWidget {
  const MapDisplay({super.key});

  @override
  State<MapDisplay> createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  late GoogleMapController mapController;
  LatLng currentPosition = const LatLng(0, 0);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget map = const Center(
    child: CircularProgressIndicator(),
  );

  void getCurrentPosition() async {
    LatLng pos = await LocationHandler.getCurrentPosition();
    setState(() {
      map = GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: pos,
          zoom: 17.0,
        ),
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return map;
  }

  @override
  void initState() {
    getCurrentPosition();
    super.initState();
  }
}
