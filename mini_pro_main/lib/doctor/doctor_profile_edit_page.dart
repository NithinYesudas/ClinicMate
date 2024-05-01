import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorProfileEditPage extends StatefulWidget {
  final String? name;
  final String? location;
  final String? experience;
  final String? about;
  final String? licenseNo;

  DoctorProfileEditPage({
    this.name,
    this.location,
    this.experience,
    this.about,
    this.licenseNo,
  });

  @override
  _DoctorProfileEditPageState createState() => _DoctorProfileEditPageState();
}

class _DoctorProfileEditPageState extends State<DoctorProfileEditPage> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _experienceController;
  late TextEditingController _aboutController;
  late TextEditingController _licenseNoController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _locationController = TextEditingController(text: widget.location);
    _experienceController = TextEditingController(text: widget.experience);
    _aboutController = TextEditingController(text: widget.about);
    _licenseNoController = TextEditingController(text: widget.licenseNo);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _experienceController.dispose();
    _aboutController.dispose();
    _licenseNoController.dispose();
    super.dispose();
  }

  Future<void> _updateDoctorProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('doctors').doc(user.uid).set({
        'name': _nameController.text,
        'location': _locationController.text,
        'experience': _experienceController.text,
        'about': _aboutController.text,
        'licenseNo': _licenseNoController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _experienceController,
              decoration: InputDecoration(
                labelText: 'Experience',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _aboutController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'About',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _licenseNoController,
              decoration: InputDecoration(
                labelText: 'License No.',
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await _updateDoctorProfile();
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
