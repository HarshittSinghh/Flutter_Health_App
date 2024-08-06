import 'package:flutter/material.dart';
import 'package:health_app/Features/BMI.dart';
import 'package:health_app/Features/Heart_rate.dart';
import 'package:health_app/Features/Step_Counter.dart';
import 'package:health_app/Features/sleep_tracker.dart';
import 'package:health_app/Features/distance_meter.dart';

class ToolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Activity Tracking Tools',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.8,
                        height: 1.4,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: const Offset(2, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/img/1.png',
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text(
                'Tracking Tools',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  // First Row with two items
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BMI(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 6,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    'assets/img/3.jpg',
                                    fit: BoxFit.cover,
                                    height: 150,  // Increased height
                                    width: double.infinity,
                                  ),
                                ),
                                const SizedBox(height: 12),  // Increased spacing
                                const Text(
                                  'BMI Calculator',
                                  style: TextStyle(
                                    fontSize: 18,  // Increased font size
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StepCounterApp(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 6,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    'assets/img/4.jpg',
                                    fit: BoxFit.cover,
                                    height: 150,  // Increased height
                                    width: double.infinity,
                                  ),
                                ),
                                const SizedBox(height: 12),  // Increased spacing
                                const Text(
                                  'Step Counter',
                                  style: TextStyle(
                                    fontSize: 18,  // Increased font size
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Second Row with remaining items
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SleepDetector(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 6,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4xzZoudIpqDQO7x5gKb29mYHgHV1jcLJTshJ06mUTxXorL33dRIfhB38rwYU9GepcraI&usqp=CAU',
                                    fit: BoxFit.cover,
                                    height: 150,  
                                    width: double.infinity,
                                  ),
                                ),
                                const SizedBox(height: 12), 
                                const Text(
                                  'Sleep Tracker',
                                  style: TextStyle(
                                    fontSize: 18,  
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HeartMonitor(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 6,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    'https://play-lh.googleusercontent.com/vi-gpl6Y5PKJR4wA3fn2xDt5PPkK0dhxpAp6Wq-dgc98v3Yi0sx7c63klVsGYGvV8nc',
                                    fit: BoxFit.cover,
                                    height: 150,  
                                    width: double.infinity,
                                  ),
                                ),
                                const SizedBox(height: 12),  
                                const Text(
                                  'Heart Monitor',
                                  style: TextStyle(
                                    fontSize: 18,  
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(children: [
                            Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TotalStatsScreen(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 6,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/3710/3710271.png',
                                    fit: BoxFit.cover,
                                    height: 150,  
                                    width: 150,
                                  ),
                                ),
                                const SizedBox(height: 12),  
                                const Text(
                                  'Total Stats',
                                  style: TextStyle(
                                    fontSize: 18,  
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                   
                  ],)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
