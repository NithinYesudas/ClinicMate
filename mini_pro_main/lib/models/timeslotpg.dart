import 'package:flutter/material.dart';

class TimeSlotPage extends StatefulWidget {
  final DateTime selectedDate; // Add this line

  const TimeSlotPage({Key? key, required this.selectedDate})
      : super(key: key); // Add this line

  @override
  _TimeSlotPageState createState() => _TimeSlotPageState();

  static of(BuildContext context) {}
}

class _TimeSlotPageState extends State<TimeSlotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Appointments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'AVAILABLE\nAPPOINTMENTS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${widget.selectedDate.day} ${_getMonth(widget.selectedDate.month)} ${widget.selectedDate.year}', // Use selectedDate from widget
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      TimeSlotButton('08:00'),
                      TimeSlotButton('10:00'),
                      TimeSlotButton('12:00'),
                      TimeSlotButton('14:00'),
                      TimeSlotButton('16:00'),
                      TimeSlotButton('18:00'),
                      TimeSlotButton('20:00'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle payment button press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              },
              child: Text('Payment'),
            ),
          ),
        ],
      ),
    );
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}

class TimeSlotButton extends StatelessWidget {
  final String time;

  TimeSlotButton(this.time);

  @override
  Widget build(BuildContext context) {
    final isSelected =
        TimeSlotPage.of(context)?.state?._selectedTimeSlot == time;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: () {
          TimeSlotPage.of(context)?.state?._selectTimeSlot(time);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.green : Colors.brown.shade100,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class AppointmentTime extends StatelessWidget {
  final String time;

  AppointmentTime(this.time);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.brown.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        time,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Text('This is the payment page.'),
      ),
    );
  }
}
