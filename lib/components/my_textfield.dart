import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final contoller;
  final String placeholder;
  final bool secretText;
  final bool valid;
  final double height;

  const MyTextField(
      {super.key,
      required this.contoller,
      required this.placeholder,
      required this.height,
      required this.valid,
      required this.secretText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        height: height,
        child: TextField(
          controller: contoller,
          obscureText: secretText,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  borderSide:
                      BorderSide(color: valid ? Colors.white : Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  borderSide:
                      BorderSide(color: valid ? Colors.blue : Colors.red)),
              fillColor: const Color.fromARGB(255, 233, 233, 233),
              hintText: placeholder,
              hintStyle: const TextStyle(fontSize: 13.5),
              filled: true),
        ),
      ),
    );
  }
}
