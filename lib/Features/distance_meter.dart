import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

void main() {
  runApp(const TotalStatsApp());
}

class TotalStatsApp extends StatelessWidget {
  const TotalStatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Total Stats',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TotalStatsScreen(),
    );
  }
}

class TotalStatsScreen extends StatefulWidget {
  const TotalStatsScreen({super.key});

  @override
  _TotalStatsScreenState createState() => _TotalStatsScreenState();
}

class _TotalStatsScreenState extends State<TotalStatsScreen> {
  late StreamSubscription<StepCount> _stepCountSubscription;
  double _totalDistance = 0.0;
  double _totalCalories = 0.0;
  int _totalSteps = 0;

  @override
  void initState() {
    super.initState();
    _initializePedometer();
  }

  void _initializePedometer() {
    _stepCountSubscription = Pedometer.stepCountStream.listen((StepCount event) {
      setState(() {
        _totalSteps = event.steps;
        _totalDistance = _calculateDistance(_totalSteps);
        _totalCalories = _calculateCalories(_totalDistance);
      });
    });
  }

  double _calculateDistance(int steps) {
    // Assume an average step length of 0.762 meters (2.5 feet)
    return steps * 0.762 / 1000; // Convert meters to kilometers
  }

  double _calculateCalories(double distance) {
    // Assume 50 calories burned per kilometer
    return distance * 50;
  }

  @override
  void dispose() {
    _stepCountSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Distance & Calories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Distance Covered Section
            Card(
              elevation: 6,
              margin: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                contentPadding: const EdgeInsets.all(20),
                title: const Text(
                  'Total Distance Covered',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${_totalDistance.toStringAsFixed(2)} km',
                  style: const TextStyle(
                    fontSize: 36,
                    color: Colors.deepPurple,
                  ),
                ),
                leading: const Icon(
                  Icons.directions_walk,
                  size: 40,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            // Calories Burned Section
            Card(
              elevation: 6,
              child: ListTile(
                contentPadding: const EdgeInsets.all(20),
                title: const Text(
                  'Total Calories Burned',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${_totalCalories.toStringAsFixed(2)} kcal',
                  style: const TextStyle(
                    fontSize: 36,
                    color: Colors.deepPurple,
                  ),
                ),
                leading: Icon(
                  Icons.fireplace,
                  size: 40,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
