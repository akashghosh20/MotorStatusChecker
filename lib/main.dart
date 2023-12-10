import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motorstatuschecker/SpalashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motor Usage Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Display the splash screen initially
    );
  }
}
