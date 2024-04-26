import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Confirmation',
      home: AppointmentConfirmationPage(
        date: '2/12/22',
        timeSlot: '03:15 pm',
      ),
    );
  }
}

class AppointmentConfirmationPage extends StatelessWidget {
  final String date;
  final String timeSlot;

  const AppointmentConfirmationPage({
    Key? key,
    required this.date,
    required this.timeSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Confirmation'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background_image.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black
                  .withOpacity(0.7), // Semi-transparent black background
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Appointment is Confirmed:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'on $date at $timeSlot',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
