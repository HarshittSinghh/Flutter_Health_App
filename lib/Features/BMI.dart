import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BMI());
}

class BMI extends StatelessWidget {
  const BMI({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.blue.shade50,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();

  var result = "";
  var status = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [
            const Text(
              "BMI Calculator",
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepPurple), 
              textAlign: TextAlign.center, 
            ),
            SizedBox(height: 30),
            TextField(
              controller: wtController,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
                prefixIcon: Icon(Icons.line_weight),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: ftController,
                    decoration: const InputDecoration(
                      labelText: "Height (ft)",
                      prefixIcon: Icon(Icons.height),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10), 
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: inController,
                    decoration: const InputDecoration(
                      labelText: "Height (in)",
                      prefixIcon: Icon(Icons.height),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                var wt = wtController.text;
                var ft = ftController.text;
                var inch = inController.text;

                if (wt != "" && ft != "" && inch != "") {
                  double weight = double.parse(wt);
                  double feet = double.parse(ft);
                  double inches = double.parse(inch);

                  double heightInMeters = (feet * 0.3048) + (inches * 0.0254);
                  double bmi = weight / (heightInMeters * heightInMeters);
                  setState(() {
                    result =
                        "Your BMI: ${bmi.toStringAsFixed(2)}"; 
                    if (bmi > 25) {
                      status = "You are Overweight"; 
                    } else if (bmi < 18) {
                      status = "You're Underweight"; 
                    } else {
                      status = "You are Healthy"; 
                    }
                  });
                } else {
                  setState(() {
                    result =
                        "Please fill all the details"; // Updated result message
                    status =
                        ""; // Clear status message if details are incomplete
                  });
                }
              },
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple), // Updated result text style
              textAlign: TextAlign.center, // Center the text
            ),
            SizedBox(height: 10),
            Text(
              status,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple), 
              textAlign: TextAlign.center, 
            ),
          ],
        ),
      ),
    );
  }
}