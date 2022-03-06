import 'dart:async';
import 'package:accelerometer/cancel_button.dart';
import 'package:accelerometer/info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';
//import 'package:async/async.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'cancel_button.dart';
import 'constants.dart';
import 'play_audio.dart';

// int number_a=0;
// int pausenumber_a=0;

PlayAudio beep = PlayAudio(
  duration: length,
  audioSound: 'beep-3.wav',
  feedbackDelay: const Duration(seconds: 0),
);

PlayAudio feed = PlayAudio(
  duration: lengthFeedback,
  audioSound: '1645293161905-voicemaker.in-speech.mp3',
  feedbackDelay: feedbackDelay,
  threshold: threshold,
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.light(primary: Color(0xFF0A0E21)),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<double> _userAccelerometerValues = [0];
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    final userAccelerometer = _userAccelerometerValues
        .map((double v) => v.toStringAsFixed(1))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return InfoPage();
                    }));
                  },
                  child: const Icon(FontAwesomeIcons.infoCircle, size: 35),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: Center(
                  child: Text(
                    '$userAccelerometer',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 100.0,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: CancelButton(),
            ))
          ],
        ),
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
          if (event.y > threshold) {
            beep.trigger = true;
            beep.cancelTimer = false;

            // number_a=1;
            feed.trigger=true;
            feed.cancelTimer=false;

          }
          // Timer.periodic(length_accel, (Timer t)
          // {
          //   //print('timer1');
          //   if (number_a==1){
          //     //print('timer2');
          //     //print('pausenumber: $pausenumber');
          //     if(pausenumber_a==0){
          //       // print('timer3');
          //       Timer.periodic(length_accel1, (Timer t)// to initialize once only
          //       {
          //         //  print('timer4');
          //         userAccelerometerValues_1.add(event.y);
          //         print(userAccelerometerValues_1);
          //       });
          //     }
          //     pausenumber_a=1;
          //   }
          // });
        },
      ),
    );

    Timer.periodic(length, (Timer t) {beep.metronome();});
    Timer.periodic(length, (Timer t) {feed.feedback();});

    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      if (threshold < event.y) {
        feed.maxAccelerometerValue = event.y;
      }
    });
  }
}
