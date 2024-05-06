import 'dart:async';
import 'dart:io';

import 'package:app/pages/home/home.dart';
import 'package:app/pages/intro/intro.dart';
import 'package:flutter/material.dart';
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

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      handleHomePage();
    } else {
      await prefs.setBool('seen', true);
      await Future.delayed(const Duration(seconds: 2));
      handleStartPage();
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
