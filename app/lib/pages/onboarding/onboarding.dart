import 'dart:async';

import 'package:app/constant/environment.dart';
import 'package:app/pages/home/home.dart';
import 'package:app/pages/intro/intro.dart';
import 'package:app/pages/auth/login/login.dart';
import 'package:app/services/auth/verify.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingPage> {
  void handleHomePage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void handleStartPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const StartPage()),
    );
  }

  void handleLoginPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<void> handlePermissions() async {
    if (await Permission.location.isDenied) {
      Permission.location.request();
    }
    if (await Permission.camera.isDenied) {
      Permission.camera.request();
    }
    if (await Permission.storage.isDenied) {
      Permission.storage.request();
    }
    if (await Permission.microphone.isDenied) {
      Permission.microphone.request();
    }
    if (await Permission.notification.isDenied) {
      Permission.notification.request();
    }
    if (await Permission.photos.isDenied) {
      Permission.photos.request();
    }
    return;
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    bool seen = (prefs.getBool(EnvironmentConstant.isFirstTime) ?? false);

    handlePermissions();

    if (seen) {
      await checkUserToken();
    } else {
      await prefs.setBool(EnvironmentConstant.isFirstTime, true);
      await Future.delayed(const Duration(seconds: 1));
      handleStartPage();
    }
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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFB5432A),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Image(
            image: AssetImage('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }
}
