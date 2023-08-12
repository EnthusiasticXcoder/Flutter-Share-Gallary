import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  const TextInputField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.blueGrey),
      decoration: InputDecoration(
        prefixIcon: (prefixIcon == null) ? null : Icon(prefixIcon),
        suffixIcon: (suffixIcon == null) ? null : Icon(suffixIcon),
        label: Text(label),
        fillColor: Colors.grey.shade50,
        filled: true,
        hintStyle: const TextStyle(color: Colors.blueGrey),
      ),
    );
  }
}
