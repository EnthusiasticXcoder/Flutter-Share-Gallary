import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gallary/pages/auth/widget/widget.dart';
import 'package:gallary/services/auth/bloc/auth_bloc.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<AuthBloc>().add(
              const AuthEventShouldSignUp(),
            );
        return Future.value(false);
      },
      child: PaintedScaffold(
        title: 'Email Verification',
        label:
            'We Have Sent A Email Verification OTP To Your Mail Account Example.123@gmail.com',
        onBack: () {
          context.read<AuthBloc>().add(
                const AuthEventShouldSignUp(),
              );
        },
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
                OTPEntry(
                  onChange: (value) {
                    if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    }
                    if (value.length == 1) {
                      context.read<AuthBloc>().add(
                            const AuthEventAuthoriseUser(),
                          );
                    }
                  },
                ),
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
      ),
    );
  }
}
