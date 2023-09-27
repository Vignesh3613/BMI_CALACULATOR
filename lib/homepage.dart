import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  Color? color1;
  double? bmi;
  void _computeBmi() {
    if (_weightController.text.isEmpty || _heightController.text.isEmpty) {
      setState(() {
        bmi = null;
      });
      return;
    }

    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);

    if (weight == null || height == null) {
      setState(() {
        bmi = null;
      });
      return;
    }

    final bmiValue = weight / ((height / 100) * (height / 100));

    setState(() {
      bmi = bmiValue;
      if (bmiValue < 17.5) {
        color1 = Colors.red;
      } else if (bmiValue >= 18.5 && bmiValue < 25) {
        color1 = Colors.black;
      } else if (bmiValue >= 25 && bmiValue < 30) {
        color1 = Colors.orange;
      } else if (bmiValue >= 30) {
        color1 = Colors.red;
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          bmi: bmi,
          color1: color1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 187, 149),
      appBar: AppBar(
          title: const Text("BMI calacutor"),
          backgroundColor: Color.fromARGB(255, 30, 199, 185)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              height: 130,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 48, 154, 125),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter Weight (in kg)',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 180,
                    color: Color.fromARGB(255, 235, 228, 228),
                    child: TextField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration:
                            const InputDecoration(hintText: "Enter Weight")),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 130,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 48, 154, 125),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter Height (in cm)',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 180,
                    color: Color.fromARGB(255, 235, 228, 228),
                    child: TextField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration:
                            const InputDecoration(hintText: "Enter height")),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => {_computeBmi()},
              child: Text(
                "compute",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 182, 170, 157))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final double? bmi;
  final Color? color1;
  const DetailScreen({super.key, required this.bmi, required this.color1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 154, 125),
      appBar: AppBar(
          title: const Text('BMI CAL'),
          backgroundColor: const Color.fromARGB(255, 48, 154, 125)),
      body: Center(
        child: Text(
          "Your BMI value is \n$bmi",
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.bold, color: color1),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {Navigator.pop(context)},
          child: const Icon(Icons.arrow_back)),
    );
  }
}
