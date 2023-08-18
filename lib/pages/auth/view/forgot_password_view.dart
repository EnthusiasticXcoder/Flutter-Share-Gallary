import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/pages/auth/auth.dart';
import 'package:gallary/services/auth/bloc/auth_bloc.dart';

class ForgotPasswordView extends StatelessWidget {
  final List<String> mail = [''];
  ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return PaintedScaffold(
      relBoxheight: 0.25,
      title: 'Reset Password',
      onBack: () {
        context.read<AuthBloc>().add(
              const AuthEventShouldSignIn(),
            );
      },
      label:
          'Enter Your Email Below, We Will Send A Password Reset Mail To Your Email',
      child: WillPopScope(
        onWillPop: () {
          context.read<AuthBloc>().add(
                const AuthEventShouldSignIn(),
              );
          return Future.value(false);
        },
        child: Column(
          children: [
            TextInputField(
              label: 'Enter Your Email',
              onChange: (value) {
                mail.removeAt(0);
                mail.insert(0, value!);
              },
            ),

            // margin
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            // Send mail Button
            ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        AuthEventForgotPassword(email: mail.firstOrNull),
                      );
                },
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                    minimumSize: Size(double.maxFinite,
                        MediaQuery.of(context).size.height * 0.055),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0))),
                child: const Text('Send Password Reset Mail')),
          ],
        ),
      ),
    );
  }
}
