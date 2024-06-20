import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

// Widget to display a modal bottom sheet for entering amounts.
class MyModalBottomSheet extends StatefulWidget {
  final TextEditingController resController;
  final double subtotal;

  const MyModalBottomSheet(
      {super.key, required this.resController, required this.subtotal});

  @override
  _MyModalBottomSheetState createState() => _MyModalBottomSheetState();
}

class _MyModalBottomSheetState extends State<MyModalBottomSheet> {
  // Appends the selected value to the current input.
  void _appendValue(String value) {
    setState(() {
      widget.resController.text += value;
    });
  }

  // Clears the current input value.
  void _clearValue() {
    setState(() {
      widget.resController.clear();
    });
  }

  // Attempts to calculate the result from the current input.
  void _calculateResult() {
    if (!mounted) return;

    String input = widget.resController.text.trim();
    if (input.isEmpty) {
      _showError('Please enter a value.');
      return;
    }

    try {
      double amount = double.parse(input);
      if (amount < 0) {
        _showError(
            'Jumlah tidak boleh kurang dari 0. Silakan masukkan jumlah yang valid.');
        _clearValue();
        return;
      }
      if (amount < widget.subtotal) {
        _showError('Silakan masukkan minimal ${NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(widget.subtotal)} atau lebih.');
        _clearValue();
        return;
      }

      setState(() {
        widget.resController.text = amount.toStringAsFixed(0);
        Navigator.of(context).pop();
      });
    } catch (e) {
      _showError('Invalid input. Please enter a valid number.');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = widget.subtotal;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Total Pembayaran: ${NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(subtotal)}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  PriceButton(price: '50000', onPressed: _appendValue),
                  PriceButton(price: '100000', onPressed: _appendValue),
                  PriceButton(price: '200000', onPressed: _appendValue),
                ],
              ),
              const Divider(),
              FocusScope(
                child: TextField(
                  controller: widget.resController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Input Nominal Bayar',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateResult,
                child: const Text('Calculate'),
              ),
              ElevatedButton(
                onPressed: _clearValue,
                child: const Text('Clear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PriceButton extends StatelessWidget {
  final String price;
  final void Function(String) onPressed;

  const PriceButton({super.key, required this.price, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(price.replaceAll('.', '')),
      child: Text(price),
    );
  }
}
// Path: lib/components/my_button_square.dart