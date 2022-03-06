import 'package:audioplayers/audioplayers.dart';
import 'dart:async';



class PlayAudio{

  bool trigger= false;//number
  bool oneTimeActivation= true;//pauseNumber
  bool cancelTimer = false;//timerNumber

  Duration duration;
  Duration feedbackDelay;
  double maxAccelerometerValue=0;
  double threshold;
  String audioSound;
  final player=AudioCache();

  PlayAudio({required this.duration,required this.audioSound,required this.feedbackDelay,this.threshold=0});

  void metronome(){
    if (trigger){
      if (oneTimeActivation){
        Timer.periodic(duration, (Timer t){

          if(cancelTimer){
            t.cancel();
          }

          player.play(audioSound);

        });
        oneTimeActivation=false;

      }
    }

}

  void feedback(){
    if (trigger){
      if (oneTimeActivation){
        Future.delayed(feedbackDelay,(){
         Timer.periodic(duration, (Timer t) {
           if (cancelTimer){
             t.cancel();

           }
           if (maxAccelerometerValue<threshold){
             player.play(audioSound);

           }
           maxAccelerometerValue=0;
         });


        });

      }
      oneTimeActivation=false;
    }

  }

  }


