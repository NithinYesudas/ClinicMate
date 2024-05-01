import 'package:flutter/material.dart';

import 'view_appointments_page.dart';

class CancelAppointmentsPage extends StatelessWidget {
  final Appointment appointment;

  const CancelAppointmentsPage({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Appointments'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Do you want to cancel all appointments for ${appointment.date.day}/${appointment.date.month}/${appointment.date.year}?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Cancel appointments logic
                    // Delete the schedule for the selected date
                    // Send notifications to users who booked appointments for that day
                    Navigator.pop(context);
                  },
                  child: Text('Yes'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
