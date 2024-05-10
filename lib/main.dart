import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const BmiCalculator());
}

class BmiCalculator extends StatelessWidget {
  const BmiCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        backgroundColor: Color(0xffE9E2F1),
        foregroundColor: Colors.black,
      )),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _ageTEController = TextEditingController();
  final TextEditingController _ftTEController = TextEditingController();
  final TextEditingController _inchTEController = TextEditingController();
  final TextEditingController _weightTEController = TextEditingController();
  double? ans = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        actions: [
          IconButton(onPressed: () { dispose();}, icon: const Icon(Icons.replay_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      controller: _ageTEController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Age'),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      controller: _ftTEController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Ht(ft)'),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      controller: _inchTEController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Ht(in)'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.male,
                            size: 30,
                          )),
                      const Text(
                        '|',
                        style: TextStyle(fontSize: 30),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.female,
                            size: 30,
                          )),
                    ],
                  ),
                  SizedBox(
                    width: 90,
                    child: TextFormField(
                      controller: _weightTEController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Weight(kg)'),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        double? age =
                            double.tryParse(_ageTEController.text) ?? 0;
                        double? ft = double.tryParse(_ftTEController.text) ?? 0;
                        double? inch =
                            double.tryParse(_inchTEController.text) ?? 0;
                        double? weight =
                            double.tryParse(_weightTEController.text) ?? 0;

                        // laws meter convert
                        // double? meter = ( ft * 12 + inch) * 0.0254

                        double? meter = (ft * 12 + inch) * 0.0254;
                        ans = weight / (meter * meter);
                        setState(() {});
                      },
                      icon: Icon(Icons.check))
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                child: SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(minimum: 16, maximum: 40, ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 16, endValue: 18, color: Colors.green),
                    GaugeRange(
                        startValue: 18, endValue: 25, color: Colors.orange),
                    GaugeRange(startValue: 25, endValue: 40, color: Colors.red)
                  ], pointers: <GaugePointer>[
                    NeedlePointer(value: (ans?.toDouble() ?? 0))
                  ], annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Text((ans?.toStringAsFixed(1)).toString(),
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        angle: 90,
                        positionFactor: 0.5)
                  ])
                ]),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Very Severly Underweight',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) <= 15.9
                                ? Colors.green
                                : Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        '<- 15.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) <= 15.9
                                ? Colors.green
                                : Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Severly Underweight',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 16.0 &&
                                    (ans?.toDouble() ?? 0) <= 16.9
                                ? Colors.green
                                : Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        '16.0- 16.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 16.0 &&
                                    (ans?.toDouble() ?? 0) <= 16.9
                                ? Colors.green
                                : Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Underweight',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 17.0 &&
                                    (ans?.toDouble() ?? 0) <= 18.4
                                ? Colors.green
                                : Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        '17.0- 18.4',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 17.0 &&
                                    (ans?.toDouble() ?? 0) <= 18.4
                                ? Colors.green
                                : Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Normal',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 18.5 &&
                                    (ans?.toDouble() ?? 0) <= 24.9
                                ? Colors.green
                                : Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        '18.5- 24.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 18.5 &&
                                    (ans?.toDouble() ?? 0) <= 24.9
                                ? Colors.green
                                : Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Overweight',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 25.0 &&
                                    (ans?.toDouble() ?? 0) <= 29.9
                                ? Colors.green
                                : Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        '25.0- 29.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 25.0 &&
                                    (ans?.toDouble() ?? 0) <= 29.9
                                ? Colors.green
                                : Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Obsese Class |',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 30.0 &&
                                    (ans?.toDouble() ?? 0) <= 34.9
                                ? Colors.green
                                : Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        '30.0- 34.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 30.0 &&
                                    (ans?.toDouble() ?? 0) <= 34.9
                                ? Colors.green
                                : Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Obsese Class ||',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 35.0 &&
                                    (ans?.toDouble() ?? 0) <= 39.9
                                ? Colors.green
                                : Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        '35.0- 39.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 35.0 &&
                                    (ans?.toDouble() ?? 0) <= 39.9
                                ? Colors.green
                                : Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Obsese Class |||',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 45.0
                                ? Colors.green
                                : Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        '>= 45.0',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 45.0
                                ? Colors.green
                                : Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Normal Weight: 117.9 - 159.4 lb',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ageTEController.clear();
    _ftTEController.clear();
    _inchTEController.clear();
    _weightTEController.clear();

  }
}
