import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gallary/pages/auth/widget/widget.dart';
import 'package:gallary/services/auth/auth.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<AuthBloc>().add(
              const AuthEventSignUp(),
            );
        return Future.value(false);
      },
      child: PaintedScaffold(
        title: 'Email Verification',
        label:
            'We Have Sent A Email Varification Link on Your Email. Please Cheack The Email And Click On The Link To Verify Your Email.',
        onBack: () {
          context.read<AuthBloc>().add(
                const AuthEventSignUp(),
              );
        },
        relBoxheight: 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('If Not Auto Redirected, Click On Continue Button.'),
            // margin

            SizedBox(height: MediaQuery.sizeOf(context).height * 0.06),
            // continue button
            OutlinedButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventCheackEmailVerification(),
                    );
              },
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black12,
                  foregroundColor: Colors.black87,
                  minimumSize: const Size.fromHeight(45),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(18))),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 18),
              ),
            ),

            // resend text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Didn\'t Recieve Mail?'),
                TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            const AuthEventResendVerificationEmail(),
                          );
                    },
                    child: const Text('Resend Mail'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
