import 'package:flutter/material.dart';

enum DialogType { success, error, info }

class AppDialog {
  static bool _isShowing = false;

  static void show(BuildContext context, DialogType type, String message) {
    if (_isShowing) return; // Prevent multiple dialogs from being shown
    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent the user from dismissing the dialog manually
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: _DialogContent(type: type, message: message),
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

class _DialogContent extends StatelessWidget {
  final DialogType type;
  final String message;

  const _DialogContent({required this.type, required this.message});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color backgroundColor;
    String title;

    // Customize the dialog based on the type
    switch (type) {
      case DialogType.success:
        icon = Icons.check_circle;
        backgroundColor = Colors.green.withOpacity(0.8);
        title = 'Success';
        break;
      case DialogType.error:
        icon = Icons.error;
        backgroundColor = Colors.red.withOpacity(0.8);
        title = 'Error';
        break;
      case DialogType.info:
        icon = Icons.info;
        backgroundColor = Colors.blue.withOpacity(0.8);
        title = 'Info';
        break;
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AppDialog.hide(context); // Hide dialog on button press
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
