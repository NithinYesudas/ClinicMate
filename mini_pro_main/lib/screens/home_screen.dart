import 'package:flutter/material.dart';
import 'package:mini_pro_main/models/appointment_booking.dart';
import 'package:mini_pro_main/models/doctors.dart';
import 'package:mini_pro_main/models/global.dart';
import 'package:mini_pro_main/screens/signin_screen.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _currentIndex = 0; // Track the current index

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            color: _currentIndex == 0 ? Colors.blue : Colors.grey,
            onPressed: () {
              setState(() {
                _currentIndex = 0; // Set the current index to 0 (home)
              });
              // Navigate to the home screen (map with doctor cards)
            },
          ),
          IconButton(
            icon: Icon(Icons.chat),
            color: _currentIndex == 1 ? Colors.blue : Colors.grey,
            onPressed: () {
              setState(() {
                _currentIndex = 1; // Set the current index to 1 (chatbot)
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            color: _currentIndex == 2 ? Colors.blue : Colors.grey,
            onPressed: () {
              setState(() {
                _currentIndex = 2; // Set the current index to 2 (notifications)
              });
              // Add your notifications logic here
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            color: _currentIndex == 3 ? Colors.blue : Colors.grey,
            onPressed: () {
              setState(() {
                _currentIndex = 3; // Set the current index to 3 (profile)
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(9.7164, 76.7137);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            myLocationButtonEnabled: false,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 400),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20.0,
                    ),
                  ],
                  color: Colors.white,
                ),
                height: 50,
                width: 300,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "What are you looking for?",
                    hintStyle: TextStyle(fontFamily: 'Gotham', fontSize: 15),
                    icon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
          ),
          /* Positioned(
            top: (MediaQuery.of(context).size.height) / 9,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.settings,
              ),
              onPressed: () {
                // Add your settings logic here
              },
            ),
          ),*/
          Container(
            padding: EdgeInsets.only(top: 550, bottom: 50),
            child: ListView(
              padding: EdgeInsets.only(left: 20),
              children: getDoctorsInArea(),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Future<List<Doctor>> getDoctors() async {
    List<Doctor> doctors = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('doctors').get();

    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        AssetImage profilePic = const AssetImage("assets/images/doctors.jpg");
        Doctor doctor = Doctor(
          data['name'] ?? 'Dr. Smith', // Use dummy name if name is null
          '070-379-031', // Dummy phone number
          data['location'] ??
              'First road 23 elm street', // Use dummy location if location is null
          529.3, // Dummy rating
          4, // Dummy totalRatings
          'Available', // Dummy status
          profilePic,
          data['speciality'] ??
              'Ptrician', // Use dummy specialization if specialization is null
        );
        doctors.add(doctor);
      }
    }
    return doctors;
  }

  List<Widget> getDoctorsInArea() {
    List<Widget> cards = [];
    getDoctors().then((doctors) {
      for (Doctor doctor in doctors) {
        cards.add(doctorCard(context, doctor));
      }
    });
    return cards;
  }

  Widget doctorCard(BuildContext context, Doctor doctor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorCard(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(right: 20),
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    backgroundImage: doctor.profilePic,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(doctor.name, style: techCardTitleStyle),
                    Text(doctor.specialization, style: techCardSubTitleStyle),
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                children: <Widget>[
                  Text("Status:  ", style: techCardSubTitleStyle),
                  Text(doctor.status, style: statusStyles[doctor.status])
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Rating: " + doctor.rating.toString(),
                          style: techCardSubTitleStyle),
                    ],
                  ),
                  Row(children: getRatings(doctor.rating))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getRatings(int rating) {
    List<Widget> ratings = [];
    for (int i = 0; i < 5; i++) {
      if (i < rating) {
        ratings.add(Icon(Icons.star, color: Colors.yellow));
      } else {
        ratings.add(Icon(Icons.star_border, color: Colors.black));
      }
    }
    return ratings;
  }

  Map statusStyles = {
    'Available': statusAvailableStyle,
    'Unavailable': statusUnavailableStyle
  };
}
