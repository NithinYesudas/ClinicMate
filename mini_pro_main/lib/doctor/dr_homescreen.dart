// doctor_home_screen.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const DoctorHomeScreen());
}

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DoctorProfilePage(),
    );
  }
}

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({super.key});

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  bool isVerified = false;

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
                hintText: 'Enter doctor\'s name...',
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
                hintText: 'Enter doctor\'s experience...',
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'About the Doctor',
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
                hintText: 'Write about the doctor...',
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Doctor\'s License No.',
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
                onPressed: () {
                  // Submit doctor profile
                  final String name = nameController.text;
                  final String location = locationController.text;
                  final String experience = experienceController.text;
                  final String about = aboutController.text;
                  final String licenseNo = licenseController.text;

                  // Perform submission (mock implementation)
                  if (name.isNotEmpty &&
                      location.isNotEmpty &&
                      experience.isNotEmpty &&
                      about.isNotEmpty &&
                      licenseNo.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Doctor profile submitted successfully!'),
                    ));
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
