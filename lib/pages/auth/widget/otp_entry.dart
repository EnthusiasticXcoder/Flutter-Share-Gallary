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
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.07,
      child: TextField(
        onChanged: onChange,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        showCursor: false,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(16.0)),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
