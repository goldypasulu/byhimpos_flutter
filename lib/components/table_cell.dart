import 'package:flutter/material.dart';

class tableCell extends StatelessWidget {
  final String text;
  const tableCell({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo[200],
      height: 30,
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
      )),
    );
  }
}
