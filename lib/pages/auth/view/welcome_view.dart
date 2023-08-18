import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gallary/pages/auth/widget/widget.dart';
import 'package:gallary/services/auth/bloc/auth_bloc.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PaintedScaffold(
      relBoxheight: 0.45,
      child: Column(
        children: [
          // Welcome Label text
          const Text(
            'Welcome To Share Gallary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const Text(
            'Easiest Way To Store and Share Photos',
          ),
          // margin
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          // sign in button for navigating to signin page
          ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventShouldSignIn(),
                    );
              },
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 16),
                  minimumSize: Size(double.maxFinite,
                      MediaQuery.of(context).size.height * 0.055),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              child: const Text('Sign in')),

          // margin
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          // sign up button for navigating to signup page
          OutlinedButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventShouldSignUp(),
                    );
              },
              style: OutlinedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 16),
                  side: const BorderSide(color: Colors.blue, width: 1.5),
                  minimumSize: Size(double.maxFinite,
                      MediaQuery.of(context).size.height * 0.055),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              child: const Text('Sign Up')),

          // margin
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          // divider label
          Divider(height: MediaQuery.of(context).size.height * 0.035),
          // google login
          OutlinedButton.icon(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventGoogleSignIn(),
                    );
              },
              icon: const Icon(Icons.g_mobiledata),
              label: const Text('Sign In with Google'))
        ],
      ),
    );
  }
}
