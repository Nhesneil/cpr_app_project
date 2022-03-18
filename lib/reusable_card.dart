import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  final VoidCallback onPress;

  ReusableContainer({required this.color,required this.cardChild, required this.onPress });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,

      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
