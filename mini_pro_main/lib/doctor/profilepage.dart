import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:mini_pro_main/doctor/profilepage.dart';
import 'package:mini_pro_main/doctor/drhomescreen2.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({super.key});

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialityController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  bool isVerified = false;

  Future<void> _storeDoctorProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('doctors').doc(user.uid).set({
        'name': nameController.text,
        'speciality': specialityController.text,
        'location': locationController.text,
        'experience': experienceController.text,
        'about': aboutController.text,
        'licenseNo': licenseController.text,
        'profileComplete': true,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name...',
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'speciality',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: specialityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your speciality',
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Location of the Clinic',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter location of the clinic...',
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Experience',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: experienceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your experience...',
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: aboutController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write about your experience and qualifications...',
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'License No.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: licenseController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter license number...',
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Verify license number (mock implementation)
                if (licenseController.text.isNotEmpty) {
                  setState(() {
                    isVerified = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('License verified successfully!'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please enter a license number.'),
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text('Verify'),
            ),
            if (isVerified) ...[
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  // Submit doctor profile
                  final String name = nameController.text;
                  final String speciality = specialityController.text;
                  final String location = locationController.text;
                  final String experience = experienceController.text;
                  final String about = aboutController.text;
                  final String licenseNo = licenseController.text;

                  // Perform submission
                  if (name.isNotEmpty &&
                      speciality.isNotEmpty &&
                      location.isNotEmpty &&
                      experience.isNotEmpty &&
                      about.isNotEmpty &&
                      licenseNo.isNotEmpty) {
                    // Store the doctor's profile data in Firestore
                    await _storeDoctorProfile();

                    // Navigate to the DrHomeScreen2 after successful submission
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DrHomeScreen2()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please fill in all fields.'),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text('Submit'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
