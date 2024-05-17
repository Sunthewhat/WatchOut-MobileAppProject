import 'dart:io';
import 'package:app/constant/environment.dart';
import 'package:app/model/report/report.dart';
import 'package:app/pages/auth/login/login.dart';
import 'package:app/services/auth/profile_image.dart';
import 'package:app/services/auth/user.dart';
import 'package:app/services/location.dart';
import 'package:app/services/report/report.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/components/report_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  var file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return file;
  }
  return null;
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userImg;
  String? userName;
  List<ReportResponse> reports = [];
  LatLng userLocation = const LatLng(0, 0);

  void _fetchCurrentPosition() async {
    LatLng pos = await LocationHandler.getCurrentPosition();
    setState(() {
      userLocation = pos;
    });
  }

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userImg = prefs.getString(EnvironmentConstant.userProfile);
    String? userName = prefs.getString(EnvironmentConstant.userName);
    if (userImg != null && userName != null) {
      setState(() {
        this.userImg = userImg;
        this.userName = userName;
      });
    } else {
      var userData = await User.getUser();
      if (userData.payload != null) {
        setState(() {
          this.userImg = userData.payload!.image;
          this.userName = userData.payload!.name;
        });
      }
    }
  }

  void getUserReport() async {
    var res = await ReportService.getUserReports();
    setState(() {
      if (res.payload != null) {
        setState(() {
          reports = res.payload!.reports;
        });
      }
    });
  }

  void logout() {
    SharedPreferences.getInstance().then((pref) => {
          pref.remove(EnvironmentConstant.userToken),
          pref.remove(EnvironmentConstant.userName),
          pref.remove(EnvironmentConstant.userProfile)
        });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false);
  }

  void selectImage() async {
    XFile? img = await pickImage(ImageSource.gallery);
    if (img == null) {
      return;
    }

    File newImg = File(img.path);
    await ProfileImage.changeProfileImage(newImg);
    var newUserData = await User.getUser();
    setState(() {
      userImg = newUserData.payload!.image;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EnvironmentConstant.userProfile, userImg!);
  }

  @override
  void initState() {
    getUserData();
    getUserReport();
    _fetchCurrentPosition();
    super.initState();
  }

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
          Container(
            color: const Color(0xFFFF6947),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: const Color(0xFFFF6947),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Profile',
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
                        ]),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    color: Colors.white,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Logout"),
                            content: const Text("Do you want to logout?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // Perform logout action here
                                  logout();
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        },
                      );
                    },
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
                  topRight: Radius.circular(45),
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
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    foregroundImage: userImg != null
                                        ? NetworkImage(userImg!)
                                        : null,
                                    radius: 40,
                                    // child: const Icon(
                                    //     Icons.account_circle_rounded),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFF6947),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        onPressed: selectImage,
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Text(
                                userName != null ? userName! : 'User Name',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Your Reports',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: reports.length,
                            itemBuilder: (BuildContext context, int index) {
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
    );
  }
}
