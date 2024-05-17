import 'package:app/components/report_card.dart';
import 'package:app/constant/environment.dart';
import 'package:app/model/report/report.dart';
import 'package:app/pages/profile/profile.dart';
import 'package:app/pages/report/create_report.dart';
import 'package:app/services/auth/user.dart';
import 'package:app/services/location.dart';
import 'package:app/services/report/calculate_distance.dart';
import 'package:app/services/report/report.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _sortBy = 'Range';
  String? userImg;
  LatLng userLocation = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _fetchReports();
    _fetchUserData();
    _fetchCurrentPosition();
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
  }

  List<ReportResponse> reports = [];
  bool isLoading = true;

  void _sortReports(String type) {
    if (reports.isEmpty) return;
    switch (type) {
      case "Range":
        reports.sort(
          (a, b) => CalculateDistance.getDistance(
            userLocation.latitude,
            userLocation.longitude,
            a.latitude,
            a.longitude,
          ).compareTo(
            CalculateDistance.getDistance(
              userLocation.latitude,
              userLocation.longitude,
              b.latitude,
              b.longitude,
            ),
          ),
        );
        break;
      case "Time":
        reports.sort((a, b) => b.time.compareTo(a.time));
        break;
    }
  }

  Future<void> _fetchReports() async {
    final response = await ReportService.getAllReports();
    if (response.success && response.payload != null) {
      setState(() {
        reports = response.payload!.reports;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      (response.message);
    }
  }

  void _fetchUserData() async {
    final userResponse = await User.getUser();
    if (userResponse.success && userResponse.payload != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
        EnvironmentConstant.userProfile,
        userResponse.payload!.image,
      );
      prefs.setString(
        EnvironmentConstant.userName,
        userResponse.payload!.name,
      );
      setState(() {
        userImg = userResponse.payload!.image;
      });
    }
  }

  void _fetchCurrentPosition() async {
    LatLng pos = await LocationHandler.getCurrentPosition();
    setState(() {
      userLocation = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double whiteBoxHeight = screenHeight * 0.85;
    double spaceAtTop = screenHeight - whiteBoxHeight;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFFF6947),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
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
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage:
                          userImg != null ? NetworkImage(userImg!) : null,
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
                            _sortReports(newValue!);
                            setState(() {
                              _sortBy = newValue;
                            });
                          },
                          items: <String>['Time', 'Range'].map((String value) {
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
                                    return CustomReportCard(
                                      report: reports[index],
                                      userLocation: userLocation,
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
