import 'package:app/components/report_card.dart';
import 'package:app/pages/profile/profile.dart';
import 'package:app/pages/report/report.dart';
import 'package:app/services/report/report.dart';
import 'package:flutter/material.dart';
import 'package:app/components/reports.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _sortBy = 'Range';
  List<Report> reports = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    final response = await ReportService.getAllReports();
    if (response.success && response.payload != null) {
      setState(() {
        reports = response.payload!.reports
            .map((r) => Report(
                  incidentType: r.type,
                  location: r.user,
                  imageUrl: r.image,
                  userName: r.user,
                  reportDescription: r.description,
                  range: r.latitude,
                  reportTime: r.time.toString(),
                  title: r.title,
                ))
            .toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      (response.message);
    }
  }

  String _formatTimeAgo(DateTime dateTime) {
    return timeago.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    if (_sortBy == 'Range') {
      reports.sort((a, b) => a.range.compareTo(b.range));
    } else if (_sortBy == 'Time') {
      reports.sort((a, b) => b.reportTime.compareTo(a.reportTime));
    }

    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the height of the white box to cover 70% of the screen vertically
    double whiteBoxHeight = screenHeight * 0.85;

    // Calculate the space left at the top of the page
    double spaceAtTop = screenHeight - whiteBoxHeight;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFFF6947),
          ),
          Positioned(
            // top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              // margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              color: const Color(0xFFFF6947),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 60),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 5,
                                offset: const Offset(1, 5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/jerrymeme.jpg'),
                      radius: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: spaceAtTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEBF4FF),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton<String>(
                          value: _sortBy,
                          onChanged: (String? newValue) {
                            setState(() {
                              _sortBy = newValue!;
                            });
                          },
                          items: <String>['Range', 'Time'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: reports.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DateTime reportDateTime = DateTime.parse(
                                        reports[index].reportTime);
                                    return CustomReportCard(
                                      title: reports[index].title,
                                      type: reports[index].incidentType,
                                      imageUrl: reports[index].imageUrl,
                                      description:
                                          reports[index].reportDescription,
                                      reporterName: reports[index].userName,
                                      location: reports[index].location,
                                      range: reports[index].range,
                                      reportTime:
                                          _formatTimeAgo(reportDateTime),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReportPage()),
          );
        },
        backgroundColor: const Color(0xFFB5432A),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
