import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {

  String information='Place phone as shown and compress for each ticking sound';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(information,
                    style: const TextStyle(fontSize: 25,),
                  ),
                ),
                Image.asset(
                  'images/phone_position.png',
                  height:250,
                  width: 250,
                ),
              ],
            ),
          ))
      );






  }
}
