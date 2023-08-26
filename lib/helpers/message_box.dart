import 'package:flutter/material.dart';

class MessageBox {
  MessageBox.showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(55.0))),
      ),
    );
  }
}