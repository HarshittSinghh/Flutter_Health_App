import 'package:flutter/material.dart';
import 'package:health_app/home_page.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _status = 'Unknown';

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      _initPedometer();
      _loadSteps();
    } else {
      setState(() {
        _status = 'Permission not granted';
      });
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
    _saveSteps(event.steps);
  }

  void _onStepCountError(error) {
    print('Step Count Error: $error');
  }

  Future<void> _saveSteps(int steps) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('steps', steps);
  }

  Future<void> _loadSteps() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _steps = prefs.getInt('steps') ?? 0;
    });
  }

  void _resetSteps() async {
    setState(() {
      _steps = 0;
    });
    await _saveSteps(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Step Counter',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyApp(),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.directions_walk,
              size: 100,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            const Text(
              'Steps taken:',
              style: TextStyle(
                fontSize: 24,
                color: Colors.deepPurple,
              ),
            ),
            Text(
              '$_steps',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _resetSteps,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Steps'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            if (_status != 'Unknown')
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  _status,
                  style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
