import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
//import 'package:async/async.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key? key, this.title}) : super(key: key);

  //final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
Color backGround = Colors.red;

class _MyHomePageState extends State<MyHomePage> {
  List<double>?
      _accelerometerValues; // question mark means that value can be null
  List<double> _userAccelerometerValues=[0]; //.... means you dont need to initialize it
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  double threshold=2;
  Color feedback() {
    setState(() {
      if (_userAccelerometerValues[0] < threshold){
        if (_userAccelerometerValues[0]  >1) {
          backGround = Colors.red;
        }
      }
      if (_userAccelerometerValues[0] > threshold){
        backGround = Colors.green;
      }
    });
    return backGround;
  }
  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final userAccelerometer = _userAccelerometerValues
        .map((double v) => v.toStringAsFixed(1))
        .toList();

    return Scaffold(
      backgroundColor: feedback(),
      // appBar: AppBar(
      //
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
              child: Center(
                child: Text(
                  '$userAccelerometer',
                  style: const TextStyle(
                    backgroundColor: Colors.white,
                    color: Colors.black,
                    fontSize: 100.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {

    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          setState(() {
            _userAccelerometerValues = <double>[event.y];
          });
        },
      ),
    );
  }
}
