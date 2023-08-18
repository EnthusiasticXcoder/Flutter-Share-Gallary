import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/services/auth/bloc/auth_bloc.dart';

import '../widget/widget.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
    return WillPopScope(
      onWillPop: () {
        context.read<AuthBloc>().add(
              const AuthEventWelcome(),
            );
        return Future.value(false);
      },
      child: PaintedScaffold(
        title: 'Sign In',
        onBack: () {
          context.read<AuthBloc>().add(
                const AuthEventWelcome(),
              );
        },
        relBoxheight: 0.4,
        // Widget in the Bottom outside the box
        bottom: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t Have an Account?'),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventShouldSignUp(),
                      );
                },
                child: const Text('Sign Up Here'))
          ],
        ),
        // Main Entry Box
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // Name or Email Input Field
            const TextInputField(
              label: 'Name or Email',
              prefixIcon: Icons.email,
            ),
            // margin
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            // Password Input Field
            StatefulBuilder(
              builder: (context, setState) => TextInputField(
                label: 'Password',
                prefixIcon: Icons.key,
                suffixIcon: Icons.remove_red_eye,
                obscureText: obscureText,
                showPassword: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
            ),
            // Forgot Password BUtton
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventForgotPassword(),
                    );
              },
              child: const Text('Forgot Password?'),
            ),

            // margin
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            // Sign in button
            ForwardLabelButton(
              onPress: () {
                context.read<AuthBloc>().add(
                      const AuthEventSignIn(),
                    );
              },
              label: 'Sign In',
            ),
          ],
        ),
      ),
    );
  }
}
