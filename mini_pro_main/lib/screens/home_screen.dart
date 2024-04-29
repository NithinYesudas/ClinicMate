/*import 'package:flutter/material.dart';
import 'package:mini_pro_main/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
        ),
      ),
    );
  }
}*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_pro_main/models/appointment_booking.dart';
import 'package:mini_pro_main/models/doctors.dart';
import 'package:mini_pro_main/models/global.dart';
import 'package:mini_pro_main/screens/signin_screen.dart';
import 'dart:async';
/*import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'models/doctors.dart';
//import 'models/global.dart';

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
          Positioned(
            top: (MediaQuery.of(context).size.height) / 9,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.settings,
              ), // Change this to your desired icon
              onPressed: () {
                // Add your onPressed logic here
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 550, bottom: 50),
            child: ListView(
              padding: EdgeInsets.only(left: 20),
              children: getDoctorsInArea(),
              scrollDirection: Axis.horizontal,
            ),
          ),
          Positioned(
            bottom: (MediaQuery.of(context).size.height) / 9,
            right: 26,
            child: IconButton(
              icon: Icon(
                Icons.chat,
                size: 60,
              ), // Change this to your desired icon
              onPressed: () {
                // Add your onPressed logic here
              },
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height) / 9,
            left: 20,
            child: ElevatedButton(
              child: Text("Logout"),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("signedout");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Doctor> getDoctors() {
    List<Doctor> doctors = [];
    for (int i = 0; i < 10; i++) {
      AssetImage profilePic = const AssetImage("assets/images/doctors.jpg");
      Doctor doctor = Doctor(
        "Dr. Smith",
        "070-379-031",
        "First road 23 elm street",
        529.3,
        4,
        "Available",
        profilePic,
        "Pediatrician",
      );
      doctors.add(doctor);
    }
    return doctors;
  }

  List<Widget> getDoctorsInArea() {
    List<Doctor> doctors = getDoctors();
    List<Widget> cards = [];
    for (Doctor doctor in doctors) {
      cards.add(doctorCard(context, doctor));
    }
    return cards;
  }
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
      ));
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
*/

import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'models/doctors.dart';
//import 'models/global.dart';

class CustomBottomNavBar extends StatelessWidget {
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
            offset: Offset(0, 3), // Changes the position of the shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("signedout");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              // Add your chatbot logic here
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add your notifications logic here
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
          Positioned(
            top: (MediaQuery.of(context).size.height) / 9,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.settings,
              ), // Change this to your desired icon
              onPressed: () {
                // Add your onPressed logic here
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 550, bottom: 50),
            child: ListView(
              padding: EdgeInsets.only(left: 20),
              children: getDoctorsInArea(),
              scrollDirection: Axis.horizontal,
            ),
          ),
          Positioned(
            bottom: (MediaQuery.of(context).size.height) / 9,
            right: 26,
            child: IconButton(
              icon: Icon(
                Icons.chat,
                size: 60,
              ), // Change this to your desired icon
              onPressed: () {
                // Add your onPressed logic here
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  List<Doctor> getDoctors() {
    List<Doctor> doctors = [];
    for (int i = 0; i < 10; i++) {
      AssetImage profilePic = const AssetImage("assets/images/doctors.jpg");
      Doctor doctor = Doctor(
        "Dr. Smith",
        "070-379-031",
        "First road 23 elm street",
        529.3,
        4,
        "Available",
        profilePic,
        "Pediatrician",
      );
      doctors.add(doctor);
    }
    return doctors;
  }

  List<Widget> getDoctorsInArea() {
    List<Doctor> doctors = getDoctors();
    List<Widget> cards = [];
    for (Doctor doctor in doctors) {
      cards.add(doctorCard(context, doctor));
    }
    return cards;
  }
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
      ));
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
