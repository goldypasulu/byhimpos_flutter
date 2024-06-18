import 'package:flutter/material.dart';

class tableRow extends StatelessWidget {
  final String text;
  final Color color;
  const tableRow({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 30,
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: color, fontSize: 11),
      )),
    );
  }
}
