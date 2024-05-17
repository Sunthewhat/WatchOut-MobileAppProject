import 'package:app/model/report/report.dart';
import 'package:app/pages/report/report_info.dart';
import 'package:app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final List<ReportResponse> reports;
  const MapPage({super.key, required this.reports});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  LatLng? initialLocation;
  bool isLoading = true;
  Set<Marker> reportsMarkers = {};

  @override
  void initState() {
    _fetchCurrentPosition();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _fetchCurrentPosition() async {
    var loc = await LocationHandler.getCurrentPosition();
    setState(() {
      initialLocation = loc;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Map View',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(1, 3),
              ),
            ],
          ),
        ),
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: const Color(0xFFB5432A),
      ),
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: initialLocation!,
                zoom: 17.0,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              scrollGesturesEnabled: true, // Disable scrolling
              zoomGesturesEnabled: true, // Disable zooming
              rotateGesturesEnabled: true, // Disable rotation
              tiltGesturesEnabled: true, // Disable tilt
              zoomControlsEnabled: false, // Disable zoom controls
              markers: widget.reports
                  .map(
                    (e) => Marker(
                      markerId: MarkerId(
                        e.id.toString(),
                      ),
                      position: LatLng(e.latitude, e.longitude),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportInfoPage(report: e),
                          ),
                        ),
                      },
                    ),
                  )
                  .toSet(),
            ),
          ),
        ],
      ),
    );
  }
}
