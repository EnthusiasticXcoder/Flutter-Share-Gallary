import 'package:flutter/material.dart';

import 'package:gallary/pages/home/home.dart';
import 'package:gallary/pages/signin/widget/widget.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return PaintedScaffold(
      title: 'Email Verification',
      label:
          'We Have Sent A Email Verification OTP To Your Mail Account Example.123@gmail.com',
      relBoxheight: 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Row>[
          // OTP Holder
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <OTPEntry>[
              // first
              OTPEntry(
                onChange: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
              // second
              OTPEntry(onChange: (value) {
                if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                } else if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              }),
              // third
              OTPEntry(
                onChange: (value) {
                  if (value.isEmpty) {
                    FocusScope.of(context).previousFocus();
                  } else if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
              // fourth
              OTPEntry(onChange: (value) {
                if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
                if (value.length == 1) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeView(),
                      ),
                      (route) => false);
                }
              }),
            ],
          ),

          // resend text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Didn\'t Recieve Code?'),
              TextButton(onPressed: () {}, child: const Text('Resend Code'))
            ],
          ),
        ],
      ),
    );
  }
}
