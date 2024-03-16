import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/services/auth/bloc/bloc.dart';

import '../widget/widget.dart';

class SignInView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final args = {
    'email': '',
    'password': '',
  };
  SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) {
        context.read<AuthBloc>().add(
              const AuthEventLogout(),
            );
      },
      child: PaintedScaffold(
        title: 'Sign In',
        onBack: () {
          context.read<AuthBloc>().add(
                const AuthEventLogout(),
              );
        },
        relBoxheight: 0.44,
        // Widget in the Bottom outside the box
        bottom: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t Have an Account?'),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventSignUp(),
                      );
                },
                child: const Text('Sign Up Here'))
          ],
        ),
        // Main Entry Box
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Name or Email Input Field
              TextInputField(
                label: 'Name or Email',
                prefixIcon: Icons.email,
                onChange: (value) {
                  args.update('email', (_) => value!);
                },
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
                  onChange: (value) {
                    args.update('password', (_) => value!);
                  },
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              // Sign in button
              ForwardLabelButton(
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    final email = args['email'];
                    final password = args['password'];
                    context.read<AuthBloc>().add(
                          AuthEventSignIn(
                            email: email,
                            password: password,
                          ),
                        );
                  }
                },
                label: 'Sign In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
