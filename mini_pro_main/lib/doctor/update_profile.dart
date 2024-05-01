// TODO Implement this library.
import 'package:flutter/material.dart';
import 'feedback.dart'; // Import the FeedbackPage

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeedbackPage()),
            );
          },
          child: Text('View Feedback'),
        ),
      ),
    );
  }
}
