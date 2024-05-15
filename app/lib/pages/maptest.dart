import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapDisplay extends StatefulWidget {
  const MapDisplay({super.key});

  @override
  State<MapDisplay> createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  late GoogleMapController mapController;
  LatLng currentPosition = const LatLng(0, 0);
  Marker? centerMarker;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _fetchCurrentPosition();
  }

  Future<void> _fetchCurrentPosition() async {
    try {
      LatLng pos = await getCurrentPosition();
      setState(() {
        currentPosition = pos;
        centerMarker = Marker(
          markerId: MarkerId("center_marker"),
          position: currentPosition,
        );
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  Future<LatLng> getCurrentPosition() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception("Location services are disabled.");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception("Location permissions are denied.");
      }
    }

    _locationData = await location.getLocation();
    return LatLng(_locationData.latitude!, _locationData.longitude!);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError) {
      return const Center(child: Text('Could not fetch location'));
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20), // Adjust the border radius as needed
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: currentPosition,
            zoom: 17.0,
          ),
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          scrollGesturesEnabled: false, // Disable scrolling
          zoomGesturesEnabled: false,   // Disable zooming
          rotateGesturesEnabled: false, // Disable rotation
          tiltGesturesEnabled: false,   // Disable tilt
          zoomControlsEnabled: false,   // Disable zoom controls
          markers: centerMarker != null ? {centerMarker!} : {},
        ),
      );
    }
  }
}
