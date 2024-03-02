import 'package:flutter/material.dart';

class ScreenFunctions {
  nextScreen(BuildContext context, screenName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenName),
    );
  }

  popScreen(BuildContext context) {
    Navigator.pop(context);
  }
}
