import 'package:app/components/reports.dart';
import 'package:app/pages/maptest.dart';
import 'package:flutter/material.dart';

class ReportInfoPage extends StatefulWidget {
  final Report report;

  const ReportInfoPage({super.key, required this.report});

  @override
  State<ReportInfoPage> createState() => _ReportInfoPageState();
}

class _ReportInfoPageState extends State<ReportInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB5432A),
      appBar: AppBar(
        title: const Text(
          'Report Information',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB5432A),
        toolbarHeight: 60.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
          color: Colors.white,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xFFFFE2DB),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      45.0), // Adjust the radius as needed
                  child: Image.asset(
                    widget.report.imageUrl,
                    width: 331.0,
                    height: 195.0,
                    fit: BoxFit.cover,
                    // Add any additional properties as needed
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Text(
                      widget.report.incidentType,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.report.location,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                // Image.asset('assets/images/map.png'),
                const SizedBox(
                  height: 230.0,
                  child: MapDisplay(),
                ),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),

                Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.report.reportDescription,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// void main() {
//   runApp(const MaterialApp(
//     home: ReportInfoPage(),
//   ));
// }
