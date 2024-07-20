import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const StepCounterApp());
}

class StepCounterApp extends StatelessWidget {
  const StepCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Step Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StepCounterHomePage(),
    );
  }
}

class StepCounterHomePage extends StatefulWidget {
  const StepCounterHomePage({super.key});

  @override
  _StepCounterHomePageState createState() => _StepCounterHomePageState();
}

class _StepCounterHomePageState extends State<StepCounterHomePage> {
  late Stream<StepCount> _stepCountStream;
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      _initPedometer();
    } else {
      print('Permission not granted');
    }
  }

  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
  }

  void _onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
    });
  }

  void _onStepCountError(error) {
    print('Step Count Error: $error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Counter'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.directions_walk,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Steps taken:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$_steps',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _steps = 0;
                });
              },
              icon: Icon(Icons.refresh),
              label: Text('Reset Steps'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
          
        ),
      ),
    );
  }
}
