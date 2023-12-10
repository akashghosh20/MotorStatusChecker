import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:motorstatuschecker/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 3 seconds, then navigate to the ControlPage
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF25242f),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Your logo image goes here
            Image.asset(
              'assets/images/mesl.jpeg', // replace with your image asset path
              width: 150, // adjust size as needed
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'MEC MECHARONICS AND EMBEDDED SYSTEM LAB',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SpinKitDoubleBounce(
              color: const Color.fromARGB(
                  255, 18, 93, 155), // Adjust color as needed
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
