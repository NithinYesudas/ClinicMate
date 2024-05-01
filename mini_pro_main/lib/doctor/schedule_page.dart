// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorSchedulePage extends StatefulWidget {
  @override
  _DoctorSchedulePageState createState() => _DoctorSchedulePageState();
}

class _DoctorSchedulePageState extends State<DoctorSchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  int _slotDuration = 15; // Duration of each time slot in minutes
  List<String> _scheduledTimeSlots = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Schedule'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2024, 5, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _showStartTimeDialog,
                  child: Text('Start Time'),
                ),
                ElevatedButton(
                  onPressed: _showEndTimeDialog,
                  child: Text('End Time'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text('Slot Duration (minutes): '),
                  const SizedBox(width: 8.0),
                  DropdownButton<int>(
                    value: _slotDuration,
                    items: const [2, 5, 7, 10, 15, 20, 30, 45, 60]
                        .map(
                          (duration) => DropdownMenuItem<int>(
                            value: duration,
                            child: Text('$duration'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _slotDuration = value;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _confirmSchedule,
              child: const Text('Schedule'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showStartTimeDialog() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  Future<void> _showEndTimeDialog() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  void _confirmSchedule() {
    if (_selectedDay == null || _startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date and time range'),
        ),
      );
      return;
    }

    _scheduledTimeSlots = []; // Initialize _scheduledTimeSlots as an empty list
    _generateTimeSlots();

    // Save the schedule data to Firestore
    _saveScheduleToFirestore();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduledTimeSlotsPage(
          date: _selectedDay!,
          timeSlots: _scheduledTimeSlots,
        ),
      ),
    );
  }

  void _generateTimeSlots() {
    if (_selectedDay == null || _startTime == null || _endTime == null) {
      return;
    }

    final start = DateTime(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
      _startTime!.hour,
      _startTime!.minute,
    );
    final end = DateTime(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
      _endTime!.hour,
      _endTime!.minute,
    );

    if (end.isBefore(start)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('End time should be after start time'),
        ),
      );
      return;
    }

    final scheduledTimeSlots = <String>[];
    var currentTime = start;

    while (currentTime.isBefore(end)) {
      final timeSlot =
          '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}';
      scheduledTimeSlots.add(timeSlot);
      currentTime = currentTime.add(Duration(minutes: _slotDuration));
    }

    setState(() {
      _scheduledTimeSlots = scheduledTimeSlots;
    });
  }

  Future<void> _saveScheduleToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doctorId =
          user.uid; // Assuming the user's UID represents the doctor's ID

      // Get a reference to the "schedules" subcollection under the doctor's document
      final scheduleRef = FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctorId)
          .collection('schedules');

      // Create a new document in the "schedules" subcollection
      await scheduleRef.add({
        'date': _selectedDay,
        'startTime': _startTime?.format(context) ??
            '', // Convert TimeOfDay to a string format
        'endTime': _endTime?.format(context) ??
            '', // Convert TimeOfDay to a string format
        'timeslots': FieldValue.arrayUnion(
            _scheduledTimeSlots), // Store time slots as a list
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Schedule saved successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not authenticated'),
        ),
      );
    }
  }
}

class ScheduledTimeSlotsPage extends StatelessWidget {
  final DateTime date;
  final List<String> timeSlots;

  const ScheduledTimeSlotsPage({
    super.key,
    required this.date,
    required this.timeSlots,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduled Time Slots'),
      ),
      body: ListView.builder(
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          return TimeSlotTile(
            timeSlot: timeSlots[index],
            onTap: () {
              // Handle time slot selection
            },
          );
        },
      ),
    );
  }
}

class TimeSlotTile extends StatelessWidget {
  final String timeSlot;
  final VoidCallback onTap;

  const TimeSlotTile({
    super.key,
    required this.timeSlot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(timeSlot),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          // Handle removing the time slot
        },
      ),
      onTap: onTap,
    );
  }
}// TODO Implement this library.