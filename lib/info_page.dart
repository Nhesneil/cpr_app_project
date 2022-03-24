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
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: Text(information,
                    style: const TextStyle(fontSize: 25,),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                    'images/Phone_v1.png',
                    height:200,
                    width: 200,
                  ),
                ),
              ],
            ),
          ))
      );






  }
}
