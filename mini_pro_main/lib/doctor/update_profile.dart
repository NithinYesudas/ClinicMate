import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'feedback.dart';
import 'doctor_profile_edit_page.dart'; // Import the DoctorProfileEditPage

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _name;
  String? _location;
  String? _experience;
  String? _about;
  String? _licenseNo;

  @override
  void initState() {
    super.initState();
    _fetchDoctorProfile();
  }

  Future<void> _fetchDoctorProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(user.uid)
          .get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        setState(() {
          _name = data?['name'];
          _location = data?['location'];
          _experience = data?['experience'];
          _about = data?['about'];
          _licenseNo = data?['licenseNo'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorProfileEditPage(
                    name: _name,
                    location: _location,
                    experience: _experience,
                    about: _about,
                    licenseNo: _licenseNo,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: $_name'),
            SizedBox(height: 10),
            Text('Location: $_location'),
            SizedBox(height: 10),
            Text('Experience: $_experience'),
            SizedBox(height: 10),
            Text('About: $_about'),
            SizedBox(height: 10),
            Text('License No.: $_licenseNo'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackPage()),
                );
              },
              child: Text('View Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
