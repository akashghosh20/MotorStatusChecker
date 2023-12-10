import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    print('Flutter Error: ${details.exception}');
    FlutterError.dumpErrorToConsole(details);
  };

  try {
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
    print('Firebase Initialized Successfully');
  } catch (e) {
    print('Firebase Initialization Error: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motor Usage Tracker',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseReference _motorStateRef;

  @override
  void initState() {
    super.initState();
    _motorStateRef = FirebaseDatabase.instance.reference();
  }

  List<int> motorUsageList = List.filled(30, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Motor Usage Tracker'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal,
                ),
                padding: EdgeInsets.all(20),
                child: StreamBuilder(
                  stream: _motorStateRef.onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.hasData) {
                      var data = snapshot.data?.snapshot.value
                          as Map<String, dynamic>?; // Explicit casting
                      motorUsageList = List.generate(30, (index) {
                        var dayKey = 'day${index + 1}';
                        return data?[dayKey] ?? 0;
                      });

                      print("Motor Usage List: $motorUsageList");

                      return LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: const Color(0xff37434d),
                              width: 1,
                            ),
                          ),
                          minX: 0,
                          maxX: motorUsageList.length.toDouble() - 1,
                          minY: 0,
                          maxY: motorUsageList
                              .reduce((value, element) =>
                                  value > element ? value : element)
                              .toDouble(),
                          lineBarsData: [
                            LineChartBarData(
                              spots: List.generate(
                                motorUsageList.length,
                                (index) => FlSpot(
                                  index.toDouble(),
                                  motorUsageList[index].toDouble(),
                                ),
                              ),
                              isCurved: true,
                              // colors: [Colors.teal],
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your Toggle Motor logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
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
