import 'package:flutter/material.dart';

class GenServices {
  static void alert(onPress, context, title, message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Tidak'),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: onPress,
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  static void success(onPress, context, title, message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              Navigator.of(context, rootNavigator: true).pop();
              onPress();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void alertError(context, title, message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
