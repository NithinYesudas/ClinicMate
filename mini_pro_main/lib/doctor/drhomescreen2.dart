// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:mini_pro_main/doctor/update_profile.dart';
import 'schedule_page.dart';
import 'view_appointments_page.dart';
//import 'feedback.dart'; // Import the FeedbackPage
// Import the ProfilePage
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(DrHomeScreen2());
}

class DrHomeScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Appointment',
      home: BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  List<Widget> screens = [
    DoctorSchedulePage(),
    ViewAppointmentsPage(),
    ProfilePage(), // Add the ProfilePage here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 160, 95, 190),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(3.0),
              child: SvgPicture.asset(
                'assets/icons/calendar.svg',
                width: 20,
                height: 20,
              ),
            ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(3.0),
              child: SvgPicture.asset(
                'assets/icons/view.svg',
                width: 20,
                height: 20,
              ),
            ),
            label: 'View',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(3.0),
              child: SvgPicture.asset(
                'assets/icons/profile.svg',
                width: 20,
                height: 20,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
