import 'package:flutter/material.dart';

class MyButtonSquareSmall extends StatelessWidget {
  final Function()? onPress;
  final String? label;
  final Color color;
  final Color color_border;
  final Color color_text;

  const MyButtonSquareSmall({
    super.key,
    required this.onPress,
    required this.label,
    required this.color,
    required this.color_border,
    required this.color_text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
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
