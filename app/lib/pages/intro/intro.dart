import 'package:app/constant/environment.dart';
import 'package:app/pages/auth/login/login.dart';
import 'package:app/services/auth/verify.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int index = 0;
  final List<String> titles = [
    "Incident Report",
    "Verification System",
    "Real-Time Alerts",
    "Post-report Guidance"
  ];
  final List<String> descriptions = [
    "Stay safe and informed with real-time incident reports, including precise GPS locations and high-quality photos/videos for accidents, robberies, floods, and more.",
    "Ensure accuracy and reliability with real-time photos for report verification, safeguarding against spam and ensuring authenticity.",
    "Deliver verified data within a customized N-kilometer range, keeping your community informed of nearby hazards for safer route adjustments.",
    "Receive precise guidance tailored to each incident type, from contacting insurance after a car accident to finding evacuation routes during floods. Get information in various formats: text, checklists, and quick video clips."
  ];

  final List<Image> images = [
    const Image(image: AssetImage('assets/images/incidentReport.png')),
    const Image(image: AssetImage('assets/images/verificationSystem.png')),
    const Image(image: AssetImage('assets/images/realtimeAlerts.png')),
    const Image(image: AssetImage('assets/images/postReportGuidance.png')),
  ];

  @override
  Widget build(BuildContext context) {
    const double dotSpacing = 8.0;
    const double imageWidthPercentage = 0.7;
    const double titleFontSize = 28;
    const double descriptionFontSize = 11;
    double descriptionBoxSize = MediaQuery.of(context).size.height * 0.2;
    const double dotSize = 15.0;

    void handleHomePage() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }

    void handleLoginPage() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }

    Future checkUserToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(EnvironmentConstant.userToken);
      if (token != null) {
        var response = await Verify.verify(token);
        if (response.success) {
          handleHomePage();
        } else {
          handleLoginPage();
        }
      } else {
        handleLoginPage();
      }
    }

    void handleNext() {
      if (index < 3) {
        setState(() {
          index++;
        });
      } else {
        checkUserToken();
      }
    }

    void handlePrev() {
      if (index > 0) {
        setState(() {
          index--;
        });
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: FractionallySizedBox(
                    widthFactor: imageWidthPercentage,
                    child: images[index],
                  ),
                ),
                Text(
                  titles[index],
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: descriptionBoxSize,
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Text(
                        descriptions[index],
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: descriptionFontSize,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                            color: Color(index == 0 ? 0xFFFF5833 : 0xFFD6E4FF),
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(width: dotSpacing),
                      Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                            color: Color(index == 1 ? 0xFFFF5833 : 0xFFD6E4FF),
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(width: dotSpacing),
                      Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                            color: Color(index == 2 ? 0xFFFF5833 : 0xFFD6E4FF),
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(width: dotSpacing),
                      Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                            color: Color(index == 3 ? 0xFFFF5833 : 0xFFD6E4FF),
                            shape: BoxShape.circle),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          index != 3
              ? Positioned(
                  bottom: 16.0,
                  right: 16.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5833),
                    ),
                    onPressed: () {
                      handleNext();
                    },
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                )
              : Container(),
          index == 3
              ? Positioned(
                  bottom: 16.0,
                  right: 16.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5833),
                    ),
                    onPressed: () {
                      handleNext();
                    },
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'Inter',
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              : Container(),
          index != 0
              ? Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA590),
                    ),
                    onPressed: () {
                      handlePrev();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
