import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_pro_main/reusable_widgets/reusable_widget.dart';
import 'package:mini_pro_main/screens/signin_screen.dart';
import 'package:mini_pro_main/utils/color_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                resuableTextfield("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                resuableTextfield("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                resuableTextfield("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(height: 20),
                signUpAsUserButton(),
                const SizedBox(height: 20),
                signUpAsDoctorButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signUpAsUserButton() {
    return signInSignUpButton(context, false, () {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((userCredential) {
        print("created new user account");
// Store user information in the 'users' collection
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': _emailTextController.text,
          'userName': _userNameTextController.text,
          // Add any other user-specific fields
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
      }).onError((error, stackTrace) {
        print("error ${error.toString()}");
      });
    }, isDoctor: false);
  }

  signUpAsDoctorButton() {
    return signInSignUpButton(context, false, () {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((userCredential) {
        print("created new doctor account");
// Store doctor information in the 'doctors' collection
        FirebaseFirestore.instance
            .collection('doctors')
            .doc(userCredential.user!.uid)
            .set({
          'email': _emailTextController.text,
          'doctorName': _userNameTextController.text,
          // Add any other doctor-specific fields
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
      }).onError((error, stackTrace) {
        print("error ${error.toString()}");
      });
    }, isDoctor: true);
  }
}
