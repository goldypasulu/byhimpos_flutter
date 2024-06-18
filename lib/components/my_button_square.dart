import 'package:flutter/material.dart';

class MyButtonSquare extends StatelessWidget {
  final Function()? onPress;
  final String? label;
  final Color color;
  final Color color_border;
  final Color color_text;

  const MyButtonSquare({
    super.key,
    required this.onPress,
    required this.label,
    required this.color,
    required this.color_border,
    required this.color_text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(color: color_border))),
          backgroundColor: MaterialStateColor.resolveWith((states) => color),
          elevation: MaterialStateProperty.all(10),
        ),
        onPressed: onPress,
        child: Center(
          child: Text(
            label!,
            style: TextStyle(color: color_text),
          ),
        ),
      ),
    );
  }
}
