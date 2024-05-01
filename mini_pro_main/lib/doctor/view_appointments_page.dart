import 'package:flutter/material.dart';
import 'cancel_appointments_page.dart'; // Import the CancelAppointmentsPage

class ViewAppointmentsPage extends StatefulWidget {
  @override
  _ViewAppointmentsPageState createState() => _ViewAppointmentsPageState();
}

class _ViewAppointmentsPageState extends State<ViewAppointmentsPage> {
  List<Appointment> appointments = [
    Appointment(
      date: DateTime(2023, 5, 1),
      patients: [
        Patient(name: 'John Doe', attended: false),
        Patient(name: 'Jane Smith', attended: false),
      ],
    ),
    Appointment(
      date: DateTime(2023, 5, 2),
      patients: [
        Patient(name: 'Alice Johnson', attended: false),
        Patient(name: 'Bob Williams', attended: false),
      ],
    ),
    // Add more appointments as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Appointments'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle date button press
                    },
                    child: Text(
                      '${appointments[index].date.day}/${appointments[index].date.month}/${appointments[index].date.year}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CancelAppointmentsPage(
                            appointment: appointments[index],
                          ),
                        ),
                      );
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: appointments[index].patients.length,
                itemBuilder: (context, patientIndex) {
                  return ListTile(
                    title:
                        Text(appointments[index].patients[patientIndex].name),
                    trailing: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          appointments[index].patients[patientIndex].attended =
                              true;
                        });
                      },
                      child: Text('Attend'),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class Appointment {
  final DateTime date;
  final List<Patient> patients;

  Appointment({
    required this.date,
    required this.patients,
  });
}

class Patient {
  final String name;
  bool attended;

  Patient({
    required this.name,
    this.attended = false,
  });
}
