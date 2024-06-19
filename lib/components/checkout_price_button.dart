import 'package:flutter/material.dart';

class PriceButton extends StatelessWidget {
  final String price;
  final Function(String) onPressed;

  const PriceButton({super.key, required this.price, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed(price.replaceAll('.', '')); // Menghilangkan titik dari harga
      },
      child: Text(price),
    );
  }
}