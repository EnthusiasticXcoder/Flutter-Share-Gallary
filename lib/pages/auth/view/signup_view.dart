import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gallary/pages/auth/widget/widget.dart';
import 'package:gallary/services/auth/bloc/auth_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<AuthBloc>().add(
              const AuthEventWelcome(),
            );
        return Future.value(false);
      },
      child: PaintedScaffold(
          title: 'Sign Up',
          onBack: () {
            context.read<AuthBloc>().add(
                  const AuthEventWelcome(),
                );
          },
          relBoxheight: 0.57,
          bottom: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already Have an Account?'),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventShouldSignIn(),
                        );
                  },
                  child: const Text('Sign In Here'))
            ],
          ),
          child: Column(
            children: <Widget>[
              // Name Input Field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <SizedBox>[
                  // First Name
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: const TextInputField(label: 'First Name'),
                  ),
                  // Last Name
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: const TextInputField(label: 'Last Name'),
                  ),
                ],
              ),
              // margin
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              // Email Input Field
              const TextInputField(label: 'Email', prefixIcon: Icons.email),
              // margin
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              // Password Input Field
              const TextInputField(
                obscureText: true,
                label: 'Password',
                prefixIcon: Icons.key,
              ),
              // margin
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              // Password Input Field
              const TextInputField(
                obscureText: true,
                label: 'Confirm Password',
                prefixIcon: Icons.password,
              ),
              // margin
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              // Sign in button
              ForwardLabelButton(
                onPress: () {
                  context.read<AuthBloc>().add(
                        const AuthEventSignUp(),
                      );
                },
                label: 'Sign Up',
              ),
            ],
          )),
    );
  }
}
