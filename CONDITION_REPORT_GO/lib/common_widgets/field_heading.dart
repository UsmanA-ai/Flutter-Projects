import 'package:flutter/material.dart';

class FieldHeading extends StatelessWidget {
  final String heading;
  const FieldHeading({
    required this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(heading,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(98, 98, 98, 1),
        ));
  }
}