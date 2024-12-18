import 'package:flutter/material.dart';

class AppLoader {
  static bool _isShowing = false;

  static void show(BuildContext context) {
    if (_isShowing) return; // Prevent multiple dialogs
    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal
      builder: (_) => const Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
    }
  }
}
