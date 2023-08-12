import 'package:flutter/material.dart';

class ForwardLabelButton extends StatelessWidget {
  final String label;
  final VoidCallback onPress;
  const ForwardLabelButton({super.key, this.label = '', required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
      trailing: IconButton(
          onPressed: onPress,
          style: IconButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            fixedSize: const Size.fromRadius(24),
          ),
          icon: const Icon(
            Icons.arrow_forward,
          )),
    );
  }
}
