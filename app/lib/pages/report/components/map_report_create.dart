import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapDisplayCreateReport extends StatefulWidget {
  final Function(LatLng) onLocationChange;
  const MapDisplayCreateReport({super.key, required this.onLocationChange});

  @override
  State<MapDisplayCreateReport> createState() => _MapDisplayCreateReportState();
}

class _MapDisplayCreateReportState extends State<MapDisplayCreateReport> {
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
          markerId: const MarkerId("center_marker"),
          position: currentPosition,
        );
        isLoading = false;
        widget.onLocationChange(currentPosition);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<LatLng> getCurrentPosition() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception("Location services are disabled.");
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception("Location permissions are denied.");
      }
    }

    locationData = await location.getLocation();
    return LatLng(locationData.latitude!, locationData.longitude!);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      centerMarker = Marker(
        markerId: const MarkerId("center_marker"),
        position: position.target,
      );
      widget.onLocationChange(position.target);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
          child: Container(
        color: const Color(0xFFFFFFFF),
        child: const CircularProgressIndicator(),
      ));
    } else if (isError) {
      return const Center(child: Text('Could not fetch location'));
    } else {
      return ClipRRect(
        borderRadius:
            BorderRadius.circular(20), // Adjust the border radius as needed
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: currentPosition,
            zoom: 17.0,
          ),
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          scrollGesturesEnabled: true, // Enable scrolling
          zoomGesturesEnabled: false, // Disable zooming
          rotateGesturesEnabled: true, // Enable rotation
          tiltGesturesEnabled: false, // Disable tilt
          zoomControlsEnabled: true, // Enable zoom controls

          markers: centerMarker != null ? {centerMarker!} : {},
          onCameraMove: _onCameraMove, // Update marker position on camera move
        ),
      );
    }
  }
}