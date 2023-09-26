import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/services/auth/auth.dart';

import '../widget/widget.dart';
class SignInView extends StatelessWidget {
  final args = {
    'Email': '',
    'Password': '',
  };
  final _formKey = GlobalKey<FormState>();
  SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
    return WillPopScope(
      onWillPop: () {

        context.read<AuthBloc>().add(
              const AuthEventLogout(),
            );
        return Future.value(false);
      },
      child: PaintedScaffold(
        title: 'Sign In',
        onBack: () {
          context.read<AuthBloc>().add(
                const AuthEventLogout(),
              );
        },
        relBoxheight: 0.43,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Name or Email Input Field
              TextInputField(
                onChange: (value) {
                  args.update('Email', (old) => value!);
                },
                label: 'Name or Email',
                prefixIcon: Icons.email,
              ),

              // Password Input Field
              StatefulBuilder(
                builder: (context, setState) => TextInputField(
                  label: 'Password',
                  prefixIcon: Icons.key,
                  suffixIcon: Icons.remove_red_eye,
                  obscureText: obscureText,
                  onChange: (value) {
                    args.update('Password', (old) => value!);
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              // Sign in button
              ForwardLabelButton(
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    final email = args['Email'];
                    final password = args['Password'];
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
