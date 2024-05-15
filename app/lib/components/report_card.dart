import 'package:app/components/reports.dart';
import 'package:app/model/report/report.dart';
import 'package:app/pages/report/report_info.dart';
import 'package:app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CustomReportCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String reporterName;
  final String location;
  final double range;
  final String reportTime;
  final String type;
  final double latitude;
  final double longitude;

  CustomReportCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.reporterName,
    required this.location,
    required this.range,
    required this.reportTime,
    required this.type,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<CustomReportCard> createState() => _CustomReportCardState();
}

class _CustomReportCardState extends State<CustomReportCard> {
  double? distance;
  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }

  Future<void> _calculateDistance() async {
    LatLng currentPosition = await LocationHandler.getCurrentPosition();
    setState(() {
      distance = Geolocator.distanceBetween(
            currentPosition.latitude,
            currentPosition.longitude,
            widget.latitude,
            widget.longitude,
          ) /
          1000; // Convert to kilometers
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportInfoPage(
              report: Report(
                incidentType: widget.type,
                location: widget.location,
                imageUrl: widget.imageUrl,
                userName: widget.reporterName,
                reportDescription: widget.description,
                range: widget.range,
                reportTime: widget.reportTime,
                title: widget.title,
                latitude: widget.latitude,
                longitude: widget.longitude,
              ),
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.reportTime,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      )),
                  Text(
                      distance != null
                          ? '${distance!.toStringAsFixed(2)} km'
                          : 'Calculating...',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      )),
                ],
              ),
            ),
            Stack(
              children: [
                Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: double.infinity,
                ),
                Positioned(
                  top: 10.0,
                  left: 10.0,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      widget.type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              color: const Color(0xFFFF6947),
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.reporterName,
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   location,
                  //   style: const TextStyle(
                  //     fontSize: 10.0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
