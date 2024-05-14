import 'package:app/components/reports.dart';
import 'package:app/pages/report/report_info.dart';
import 'package:flutter/material.dart';

class CustomReportCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String reporterName;
  final String location;
  final double range;
  final String reportTime;

  const CustomReportCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.reporterName,
    required this.location,
    required this.range,
    required this.reportTime,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportInfoPage(
              report: Report(
                incidentType: title,
                location: location,
                imageUrl: imageUrl,
                userName: reporterName,
                reportDescription: description,
                range: range,
                reportTime: reportTime,
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
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(reportTime,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      )),
                  Text('$range km',
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
                  imageUrl,
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
                      title,
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
                description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    reporterName,
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
