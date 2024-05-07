import 'package:app/pages/onboarding/onboarding.dart';
import 'package:app/pages/report/report.dart';
import 'package:app/pages/report/report_info.dart';
import 'package:app/pages/report/report_with_photo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ReportPage(),
    );
  }
}
