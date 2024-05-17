import 'package:app/model/report/report.dart';
import 'package:app/pages/report/report_info.dart';
import 'package:app/services/report/calculate_distance.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomReportCard extends StatelessWidget {
  final ReportResponse report;
  final LatLng userLocation;

  const CustomReportCard({
    super.key,
    required this.report,
    required this.userLocation,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportInfoPage(report: report),
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
                  Text(timeago.format(report.time),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      )),
                  Text(
                      '${CalculateDistance.getDistance(
                        userLocation.latitude,
                        userLocation.longitude,
                        report.latitude,
                        report.longitude,
                      )} km',
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
                  report.image,
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
                      report.type,
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
                report.title,
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
                    report.user,
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
