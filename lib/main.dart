import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const MyHomePage(title: 'BMI App'),
    );
  }
}

final wtController = TextEditingController();
final ftController = TextEditingController();
final inchController = TextEditingController();
var msg = "";
var bmi;
Color bgColor = Colors.indigo.shade200;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        color: bgColor,
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "BMI App",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextField(
                  controller: wtController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.line_weight),
                      labelText: "Enter your weight(kg)"),
                ),
                TextField(
                  controller: ftController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Enter your height(feet)"),
                ),
                TextField(
                  controller: inchController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.height),
                    labelText: "Enter your height(inches)",
                  ),
                ),
                SizedBox(
                  height: 34,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (wtController.text.isEmpty ||
                        ftController.text.isEmpty ||
                        inchController.text.isEmpty) {
                      msg = "Please fill all the fields!";
                    } else {
                      // BMI calculation
                      var wt = int.parse(wtController.text.toString());
                      var ft = int.parse(ftController.text.toString());
                      var inch = int.parse(inchController.text.toString());
                      var totalInch = (ft * 12) + inch;
                      var totalMeter = (totalInch * 2.54) / 100;
                      var bmiFloat = wt / (totalMeter * totalMeter);
                      bmi = bmiFloat.toStringAsFixed(2);
                      var ibmi = double.parse(bmi);

                      if (ibmi < 18) {
                        bgColor = Colors.red.shade300;
                        msg = "Your BMI is $bmi, Underweight";
                      } else if (ibmi > 25) {
                        bgColor = Colors.orange.shade200;
                        msg = "Your BMI is $bmi, Overweight";
                      } else {
                        bgColor = Colors.green.shade200;
                        msg = "Your BMI is $bmi, Fit";
                      }
                    }

                    setState(() {});
                  },
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade700,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "$msg",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
