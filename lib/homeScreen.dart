import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseReference _motorStateRef;

  @override
  void initState() {
    super.initState();
    _motorStateRef = FirebaseDatabase.instance.reference().child('motorState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motor Usage Tracker'),
        backgroundColor: Colors.teal, // Set your preferred color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal, // Set your preferred color
              ),
              padding: EdgeInsets.all(20),
              child: StreamBuilder(
                stream: _motorStateRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data?.snapshot.value != null) {
                    Object? isMotorOn = snapshot.data!.snapshot.value;
                    return Icon(
                      isMotorOn != null
                          ? Icons.power_settings_new
                          : Icons.power_off,
                      color: Colors.white,
                      size: 100,
                    );
                  } else {
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Set your preferred color
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Toggle Motor',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
