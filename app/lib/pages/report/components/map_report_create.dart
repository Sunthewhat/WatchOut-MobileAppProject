import 'package:app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDisplayCreateReport extends StatefulWidget {
  final Function(LatLng) onLocationChange;
  final LatLng? point;

  const MapDisplayCreateReport({
    super.key,
    required this.onLocationChange,
    required this.point,
  });

  @override
  State<MapDisplayCreateReport> createState() => _MapDisplayCreateReportState();
}

class _MapDisplayCreateReportState extends State<MapDisplayCreateReport> {
  GoogleMapController? mapController;
  LatLng currentPosition = const LatLng(0, 0);
  Marker? centerMarker;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _fetchCurrentPosition();
  }

  @override
  void didUpdateWidget(MapDisplayCreateReport oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.point != null && widget.point != oldWidget.point) {
      _updateMarkerPosition(widget.point!);
    }
  }

  Future<void> _fetchCurrentPosition() async {
    try {
      LatLng pos = await LocationHandler.getCurrentPosition();
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
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
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

  void _updateMarkerPosition(LatLng newPoint) {
    setState(() {
      currentPosition = newPoint;
      centerMarker = Marker(
        markerId: const MarkerId("center_marker"),
        position: newPoint,
      );
    });

    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLng(newPoint));
    }
  }

  void _openFullScreenMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenMap(initialPosition: currentPosition),
      ),
    );

    if (result != null && result is LatLng) {
      _updateMarkerPosition(result);
      widget.onLocationChange(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: const SizedBox(
          height: 230,
          child: Center(
            child: Text('Could not fetch location'),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 230,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: widget.point ?? currentPosition,
                  zoom: 17.0,
                ),
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                scrollGesturesEnabled: false, // Disable scrolling
                zoomGesturesEnabled: false, // Disable zooming
                rotateGesturesEnabled: false, // Disable rotation
                tiltGesturesEnabled: false, // Disable tilt
                zoomControlsEnabled: false, // Disable zoom controls
                markers: centerMarker != null ? {centerMarker!} : {},
                onCameraMove: _onCameraMove,
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _openFullScreenMap,
                  child: const Center(
                    child: Text(
                      'Tap to select location',
                      style: TextStyle(
                          color: Colors.white, backgroundColor: Colors.black45),
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

  void _onCameraMove(CameraPosition position) {
    setState(() {
      selectedPosition = position.target;
      selectedMarker = Marker(
        markerId: const MarkerId("selected_marker"),
        position: selectedPosition,
      );
    });
  }

  void _onSelectLocation() {
    Navigator.pop(context, selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _onSelectLocation,
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
        onCameraMove: _onCameraMove,
      ),
    );
  }
}
