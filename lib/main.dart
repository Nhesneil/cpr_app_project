import 'dart:async';
import 'package:accelerometer/Cancel_button.dart';
import 'package:accelerometer/Info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
//import 'package:async/async.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'Cancel_button.dart';

const double threshold = 2;
int number=0;
int pausenumber=0;
int timenumber=0;
int number_a=0;
int pausenumber_a=0;



const length = Duration(milliseconds:500);
const length_accel = Duration(milliseconds:5);
const length_accel1 = Duration(milliseconds:5000);

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
  //MyHomePage({Key? key, this.title}) : super(key: key);

  //final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<double>?
      _accelerometerValues; // question mark means that value can be null
  List<double> _userAccelerometerValues = [
    0
  ];
  List  <double> userAccelerometerValues_1=[];

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  //
  // Color backGround = Colors.red; //starting value, can be declared instead class
  //
  // Color feedback() {
  //   setState(() {
  //     if (_userAccelerometerValues[0] < threshold) {
  //       if (_userAccelerometerValues[0] > 1) {
  //         backGround = Colors.red;
  //       }
  //     }
  //     if (_userAccelerometerValues[0] > threshold) {
  //       backGround = Colors.green;
  //     }
  //   });
  //   return backGround;
  // }




  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final userAccelerometer = _userAccelerometerValues
        .map((double v) => v.toStringAsFixed(1))
        .toList();


    return Scaffold(
      //backgroundColor: feedback(),
      // appBar: AppBar(
      //
      // ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return InfoPage();
                    }));
                    },
                  child: const Icon(FontAwesomeIcons.infoCircle,
                  size: 35),
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
                      //backgroundColor: Colors.white,
                      color: Colors.white,
                      fontSize: 100.0,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: LoadingButton(),
              // child: MaterialButton(
              //   child: Text(
              //     'CANCEL'
              //   ),
              //   onPressed: (){
              //     timenumber=1;
              //   },
              // )
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
        (UserAccelerometerEvent event) async{
          setState(() {
            _userAccelerometerValues = <double>[event.y];

          });
          if (event.y>threshold){
            timenumber=0;
            number=1;
            number_a=1;
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
    Timer.periodic(length, (Timer t)
    {
      //print('timer1');
      if (number==1){
        //print('timer2');
        //print('pausenumber: $pausenumber');
        if(pausenumber==0){
         // print('timer3');

          Timer.periodic(length, (Timer t)// to initialize once only
          {
            if(timenumber==1){
              t.cancel();
            }

         //  print('timer4');
            final player = AudioCache();
            player.play('beep-3.wav');
          });
        }
        pausenumber=1;
      }
    });
  }
}

