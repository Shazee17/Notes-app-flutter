import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_app_flutter/pages/notes_page.dart'; // Import your NotesPage

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3), // Adjust the duration as needed
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NotesPage(), // Navigate to your NotesPage
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Adjust the background color as needed
      body: Center(
        child: Image.asset("assets/logo.png", height: 150, width: 150,) // Adjust the image path as needed
      ),
    );
  }
}
