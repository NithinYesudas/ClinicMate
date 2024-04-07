import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_pro_main/screens/home_screen.dart';
import 'package:mini_pro_main/screens/signup_screen.dart';
import 'package:mini_pro_main/utils/color_utils.dart';

import '../reusable_widgets/reusable_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  String _emailErrorMessage = '';
  String _passwordErrorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.32, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget('assets/images/logo1.png'),
                const SizedBox(
                  height: 30,
                ),
                resuableTextfield("Enter email", Icons.person_outline, false,
                    _emailTextController),
                ErrorMessageWidget(errorMessage: _emailErrorMessage),
                const SizedBox(
                  height: 30,
                ),
                resuableTextfield("Enter passwordd", Icons.lock_outline, true,
                    _passwordTextController),
                ErrorMessageWidget(errorMessage: _passwordErrorMessage),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(
                  context,
                  true,
                  signInWithEmailAndPassword,
                ),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  signInWithEmailAndPassword() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _emailTextController.text,
      password: _passwordTextController.text,
    )
        .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }).onError((error, stackTrace) {
      setState(() {
        _emailErrorMessage = '';
        _passwordErrorMessage = '';

        if (error is FirebaseAuthException) {
          if (error.code == 'user-not-found') {
            _emailErrorMessage = 'User not found';
          } else if (error.code == 'invalid-password') {
            _passwordErrorMessage = 'wrong password';
          } else if (error.code == 'invalid-email') {
            _emailErrorMessage = 'Invalid email address';
          } else {
            // Handle other error codes or provide a generic error message
            //_emailErrorMessage = 'An error occurred: ${error.code}';
            _passwordErrorMessage = 'Wrong password';
          }
        } else {
          // Handle the case where error is not a FirebaseAuthException
          _emailErrorMessage = 'An unknown error occurred';
          _passwordErrorMessage = 'An unknown error occurred';
        }
      });
    });
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
