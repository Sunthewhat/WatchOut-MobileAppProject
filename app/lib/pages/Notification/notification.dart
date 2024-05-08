import 'package:app/pages/home/home.dart';
import 'package:app/pages/report/report_info.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Report> reports = [
    Report(
      incidentType: 'Flood',
      location: 'Orlando, Florida',
      imageUrl: 'assets/images/flood.jpg',
      userName: 'Jack Sparrow',
      userProfile: 'assets/images/man1.jpg',
      reportDescription: 'flood at the village',
    ),
    Report(
      incidentType: 'Earthquake',
      location: 'Tokyo, Japan',
      imageUrl: 'assets/images/earthquake.jpg',
      userName: 'Segun adebayo',
      userProfile: 'assets/images/man2.jpg',
      reportDescription: 'Big earthquake in the city',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the height of the white box to cover 70% of the screen vertically
    double whiteBoxHeight = screenHeight * 0.85;

    // Calculate the space left at the top of the page
    double spaceAtTop = screenHeight - whiteBoxHeight;

    return Scaffold(
      body: Stack(
        children: [
          // Blue background
          Container(
            color: const Color(0xFF2960AE),
          ),
          // Profile label
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 35),
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: const Color(0xFF2960AE),
              child: Center(
                child: Text(
                  'Notification',
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
              ),
            ),
          ),
          // White box overlay
          Positioned(
            top: spaceAtTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEBF4FF),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45), // Add top left border radius
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User Reports

                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: reports.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ReportCard(
                                imageUrl: reports[index].imageUrl,
                                userName: reports[index].userName,
                                userProfile: reports[index].userProfile,
                                reportDescription:
                                    reports[index].reportDescription,
                                location: reports[index].location,
                                incidentType: reports[index].incidentType,
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
    );
  }
}

class ReportCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String userProfile;
  final String reportDescription;
  final String location;
  final String incidentType;

  const ReportCard({
    super.key,
    required this.imageUrl,
    required this.userName,
    required this.userProfile,
    required this.reportDescription,
    required this.location,
    required this.incidentType,
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
                incidentType: incidentType,
                location: location,
                imageUrl: imageUrl,
                userName: userName,
                userProfile: userProfile,
                reportDescription: reportDescription,
              ),
            ),
          ),
        );
      },
      child: Card(
        elevation: 8,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16.0)),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(userProfile),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 150,
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  reportDescription,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: Text(
                incidentType,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
