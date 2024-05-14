import 'dart:io';
import 'package:app/services/auth/profile_image.dart';
import 'package:app/services/auth/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/components/report_card.dart';
import 'package:app/components/reports.dart';

Future pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  var file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return file;
  }
  print('No Images Selected');
  return null;
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Uint8List? _image;
  String? userImg;

  void getUserData() async {
    var user = await User.getUser();
    setState(() {
      if (user.payload != null) {
        userImg = user.payload!.image;
      }
    });
  }

  void selectImage() async {
    XFile? img = await pickImage(ImageSource.gallery);
    File newImg = File(img!.path);
    await ProfileImage.changeProfileImage(newImg);
    var newUserData = await User.getUser();
    setState(() {
      userImg = newUserData.payload!.image;
    });
  }

  final List<Report> reports = [
    // Report(
    //   incidentType: 'Wildfire',
    //   location: 'Ang thong, Bangkok',
    //   imageUrl: 'assets/images/wildfire.jpg',
    //   userName: 'John Doe',
    //   reportDescription: 'Wild fire near my house',
    //   range: 5.0,
    //   reportTime: '2 hours ago',
    // ),
  ];

  @override
  void initState() {
    getUserData();
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
              margin: const EdgeInsets.only(top: 35),
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
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
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
                              const Text(
                                'John Doe',
                                style: TextStyle(
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
                                title: reports[index].incidentType,
                                imageUrl: reports[index].imageUrl,
                                description: reports[index].reportDescription,
                                reporterName: reports[index].userName,
                                location: reports[index].location,
                                range: reports[index].range,
                                reportTime: reports[index].reportTime,
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
