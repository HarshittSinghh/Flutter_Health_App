import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';

class SleepDetector extends StatefulWidget {
  @override
  _SleepDetectorState createState() => _SleepDetectorState();
}

class _SleepDetectorState extends State<SleepDetector> {
  List<double> _accelerometerValues = <double>[0.0, 0.0, 0.0];
  bool _isSleeping = false;
  DateTime? _sleepStartTime;
  DateTime? _sleepEndTime;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndListen();
  }

  Future<void> _checkPermissionsAndListen() async {
    try {
      accelerometerEvents.listen((AccelerometerEvent event) {
        setState(() {
          _accelerometerValues = <double>[event.x, event.y, event.z];
          _detectSleep();
        });
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Sensor access not granted';
      });
    }
  }

  void _detectSleep() {
    double magnitude = sqrt(
      pow(_accelerometerValues[0], 2) +
      pow(_accelerometerValues[1], 2) +
      pow(_accelerometerValues[2], 2)
    );

    if (magnitude < 0.5) {
      if (!_isSleeping) {
        _isSleeping = true;
        _sleepStartTime = DateTime.now();
      }
    } else {
      if (_isSleeping) {
        _isSleeping = false;
        _sleepEndTime = DateTime.now();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer = _accelerometerValues.map((double v) => v.toStringAsFixed(1)).toList();

    String sleepDurationText = 'N/A';
    if (_isSleeping && _sleepStartTime != null) {
      final sleepDuration = DateTime.now().difference(_sleepStartTime!);
      sleepDurationText = '${sleepDuration.inMinutes} minutes';
    } else if (!_isSleeping && _sleepStartTime != null && _sleepEndTime != null) {
      final sleepDuration = _sleepEndTime!.difference(_sleepStartTime!);
      sleepDurationText = '${sleepDuration.inMinutes} minutes';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sleep Detector',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[850]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: Colors.grey[900],
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: _errorMessage.isNotEmpty
                    ? Text(
                        _errorMessage,
                        style: TextStyle(fontSize: 18, color: Colors.redAccent),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Accelerometer Data',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'X: ${accelerometer[0]}',
                            style: TextStyle(fontSize: 18, color: Colors.white70),
                          ),
                          Text(
                            'Y: ${accelerometer[1]}',
                            style: TextStyle(fontSize: 18, color: Colors.white70),
                          ),
                          Text(
                            'Z: ${accelerometer[2]}',
                            style: TextStyle(fontSize: 18, color: Colors.white70),
                          ),
                          SizedBox(height: 20),
                          Text(
                            _isSleeping ? 'User is sleeping' : 'User is awake',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: _isSleeping ? Colors.greenAccent : Colors.redAccent,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Sleep Duration: $sleepDurationText',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white60,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          if (_sleepStartTime != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Sleep Start Time: ${_sleepStartTime!.toLocal().toString().split('.')[0]}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white60,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
