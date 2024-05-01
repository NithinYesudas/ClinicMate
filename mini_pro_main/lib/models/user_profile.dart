import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_pro_main/screens/signin_screen.dart';
//import 'package:mini_pro_main/screens/appointment_details_screen.dart'; // Import the appointment details screen

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String _userName = '';
  String _userEmail = '';
  List<Appointment> _userAppointments = []; // Dummy data for appointments

  @override
  void initState() {
    super.initState();
    _getUserData();
    _fetchUserAppointments(); // Fetch user appointments
  }

  Future<void> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userName = user.displayName ?? '';
        _userEmail = user.email ?? '';
      });
    }
  }

  Future<void> _fetchUserAppointments() async {
    // Replace this with your logic to fetch user appointments from the backend
    setState(() {
      _userAppointments = [
        Appointment(
          doctorName: 'Dr. Smith',
          date: DateTime.now().add(Duration(days: 3)),
          time: TimeOfDay(hour: 10, minute: 30),
        ),
        Appointment(
          doctorName: 'Dr. Johnson',
          date: DateTime.now().add(Duration(days: 7)),
          time: TimeOfDay(hour: 14, minute: 0),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.purple,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                SizedBox(height: 8),
                Text(
                  _userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _userEmail,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('My Profile'),
                ),
                ListTile(
                  leading: Icon(Icons.event),
                  title: Text('My Appointments'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentDetailsScreen(
                          appointments: _userAppointments,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Location'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      print("signedout");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Appointment {
  final String doctorName;
  final DateTime date;
  final TimeOfDay time;

  Appointment({
    required this.doctorName,
    required this.date,
    required this.time,
  });
}

class AppointmentDetailsScreen extends StatelessWidget {
  final List<Appointment> appointments;

  AppointmentDetailsScreen({required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Card(
            child: ListTile(
              title: Text('Appointment with ${appointment.doctorName}'),
              subtitle: Text(
                'Date: ${appointment.date.toString().split(' ')[0]}\nTime: ${appointment.time.format(context)}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      // Cancel appointment logic
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      // View appointment details
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
