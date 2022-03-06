import 'package:flutter/material.dart';
import 'main.dart';

const double height=60.0;
const double width=60.0;

class CancelButton extends StatefulWidget {
  @override
  CancelButtonState createState() => CancelButtonState();
}

class CancelButtonState extends State<CancelButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.addListener(() {
      setState(() {});// setstate to rebuild in build
    });//Listener to get the controller value (usually from 0 to 1)
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => controller.forward(),
      onTapUp: (_) {
        if (controller.status == AnimationStatus.forward) {
          controller.reverse();

        }
        if(controller.value==1) {
          controller.reset();

          beep.trigger=false;
          beep.oneTimeActivation=false;
          beep.cancelTimer=true;

          feed.trigger=false;
          feed.oneTimeActivation=false;
          feed.cancelTimer=true;

        }},
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const SizedBox(
              height: height,
              width: width,
              child: CircularProgressIndicator(
                value: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ),
            SizedBox(
              height: height,
              width: width,
              child: CircularProgressIndicator(
                value: controller.value,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            const Text('CANCEL'),
          ],
        ),
      ),
    );
  }
}