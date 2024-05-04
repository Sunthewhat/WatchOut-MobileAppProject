import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          // Report Cards
          ReportCard(
            imageUrl: 'assets/incident_image.jpg', // Replace with actual image URL
            userName: 'John Doe', // Replace with actual user name
            userProfile: 'assets/profile_image.jpg', // Replace with actual profile image URL
          ),
          // Add more ReportCards here as needed
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Navigate to notification page
              },
            ),
            IconButton(
              icon: Icon(Icons.report),
              onPressed: () {
                // Navigate to reporting page
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                // Navigate to profile page
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String userProfile;

  ReportCard({required this.imageUrl, required this.userName, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(userProfile),
        ),
        title: Text(userName),
        subtitle: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          height: 200.0, // Adjust as needed
          width: double.infinity,
        ),
        // Add onTap function to handle report details
        onTap: () {
          // Add functionality to view report details
        },
      ),
    );
  }
}
