import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDisplay extends StatefulWidget {
  final LatLng casePosition;

  const MapDisplay({super.key, required this.casePosition});

  @override
  State<MapDisplay> createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _openFullScreenMap() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FullScreenMap(initialPosition: widget.casePosition),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: widget.casePosition,
                zoom: 17.0,
              ),
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              scrollGesturesEnabled: false, // Disable scrolling
              zoomGesturesEnabled: false, // Disable zooming
              rotateGesturesEnabled: false, // Disable rotation
              tiltGesturesEnabled: false, // Disable tilt
              zoomControlsEnabled: false, // Disable zoom controls
              markers: {
                Marker(
                    markerId: const MarkerId("Report Location"),
                    position: widget.casePosition)
              },
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _openFullScreenMap,
                child: const Center(
                  child: Text(
                    'Tap to see fullscreen',
                    style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Color.fromARGB(60, 0, 0, 0)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenMap extends StatefulWidget {
  final LatLng initialPosition;

  const FullScreenMap({super.key, required this.initialPosition});

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  GoogleMapController? mapController;
  LatLng selectedPosition = const LatLng(0, 0);
  Marker? selectedMarker;

  @override
  void initState() {
    super.initState();
    selectedPosition = widget.initialPosition;
    selectedMarker = Marker(
      markerId: const MarkerId("selected_marker"),
      position: selectedPosition,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapClose() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single report Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: _onMapClose,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: selectedPosition,
          zoom: 17.0,
        ),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        scrollGesturesEnabled: true, // Enable scrolling
        zoomGesturesEnabled: true, // Enable zooming
        rotateGesturesEnabled: true, // Enable rotation
        tiltGesturesEnabled: true, // Enable tilt
        zoomControlsEnabled: true, // Enable zoom controls
        markers: selectedMarker != null ? {selectedMarker!} : {},
      ),
    );
  }
}
