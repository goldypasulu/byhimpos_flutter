import 'package:flutter/material.dart';

class FlatButton extends StatelessWidget {
  final Function()? onPress;
  final String? label;

  const FlatButton({super.key, required this.onPress, required this.label});

  @override
  Widget build(BuildContext context) {
    // The InkWell wraps the custom flat button widget.
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.orange, // Outline color
            ),
            borderRadius: BorderRadius.circular(
                8), // You can adjust the radius as per your preference
          ),
          child: Center(
            child: Text(
              label!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                // Text color
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
