// dr_home_screen2.dart
import 'package:flutter/material.dart';

class DrHomeScreen2 extends StatelessWidget {
  const DrHomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Home Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Doctor Home Screen'),
      ),
    );
  }
}
