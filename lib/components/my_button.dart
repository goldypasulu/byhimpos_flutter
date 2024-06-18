import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onPress;
  final String? label;
  final Color color;

  const MyButton(
      {super.key,
      required this.onPress,
      required this.label,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => color),
          elevation: MaterialStateProperty.all(10),
        ),
        onPressed: onPress,
        child: Center(
          child: Text(
            label!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
