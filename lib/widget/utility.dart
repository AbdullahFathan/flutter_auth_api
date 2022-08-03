import 'package:flutter/material.dart';

class Utility {
  // Reuseable Snackbar for showing Messenger
  showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
