import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motorstatuschecker/SpalashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBA14X5RRMxVwP7WQUcDnz28NJ7D59czDg',
      authDomain: 'motorstatuschecker.firebaseapp.com',
      projectId: 'motorstatuschecker',
      storageBucket: 'motorstatuschecker.appspot.com',
      messagingSenderId: '673010239596',
      appId: '1:673010239596:android:b969381521d58713ac7049',
      databaseURL: 'https://motorstatuschecker-default-rtdb.firebaseio.com',
    ),
  );

  print('Connected to Firebase Database');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motor Usage Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Display the splash screen initially
    );
  }
}
