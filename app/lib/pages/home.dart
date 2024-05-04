import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF4FF),
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white, fontSize: 40, shadows: [
            Shadow(
              color: Colors.black,
              blurRadius: 5,
              offset: Offset(1, 5),
            ),
          ]),
        ),
        backgroundColor: Color(0xFF2960AE),
        elevation: 4,
        toolbarHeight: 130,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          // Report Cards
          _buildReport(
            incidentType: 'Wildfire',
            reportCard: ReportCard(
              imageUrl: 'assets/images/wildfire.jpg',
              userName: 'จนปัญญาว่ะ',
              userProfile: 'assets/images/jerrymeme.jpg',
            ),
          ),
          _buildReport(
            incidentType: 'Wildfire',
            reportCard: ReportCard(
              imageUrl: 'assets/images/wildfire.jpg',
              userName: 'จนปัญญาว่ะ',
              userProfile: 'assets/images/jerrymeme.jpg',
            ),
          ),
          _buildReport(
            incidentType: 'Wildfire',
            reportCard: ReportCard(
              imageUrl: 'assets/images/wildfire.jpg',
              userName: 'จนปัญญาว่ะ',
              userProfile: 'assets/images/jerrymeme.jpg',
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF2960AE),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.report),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReport({
    required String incidentType,
    required Widget reportCard,
  }) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                incidentType,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.0), // Add spacing between text and card
          reportCard,
        ],
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String userProfile;

  ReportCard({
    required this.imageUrl,
    required this.userName,
    required this.userProfile,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
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
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(userProfile),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    userName,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
