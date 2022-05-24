import 'package:flutter/material.dart';

class TunerCard extends StatelessWidget {
  const TunerCard(
      {Key? key,
        required this.colour,
        required this.cardChild,
        required this.onPress})
      : super(key: key);

  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        child: cardChild,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.only(top: 5.0),
        decoration: BoxDecoration(
          color: colour,
          border: Border.all(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}