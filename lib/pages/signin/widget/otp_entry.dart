import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show LengthLimitingTextInputFormatter, FilteringTextInputFormatter;

typedef ValueCallBack = void Function(String);

class OTPEntry extends StatelessWidget {
  final ValueCallBack onChange;
  const OTPEntry({
    super.key,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        onChanged: onChange,
        showCursor: false,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
