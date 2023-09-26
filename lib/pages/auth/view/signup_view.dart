import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/pages/auth/auth.dart';
import 'package:gallary/services/auth/auth.dart';

class SignUpView extends StatelessWidget {
  final args = {
    'Name': '',
    'Email': '',
    'Password': '',
    'Confirm Password': '',
  };
  final _formKey = GlobalKey<FormState>();
  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<AuthBloc>().add(
              const AuthEventLogout(),
            );
        return Future.value(false);
      },
      child: PaintedScaffold(
          title: 'Sign Up',
          onBack: () {
            context.read<AuthBloc>().add(
                  const AuthEventLogout(),
                );
          },
          relBoxheight: 0.6,
          bottom: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already Have an Account?'),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventSignIn(),
                        );
                  },
                  child: const Text('Sign In Here'))
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Name Input Field
                TextInputField(
                  label: 'Full Name',
                  onChange: (value) {
                    args.update('Name', (old) => value!);
                  },
                ),

                // Email Input Field
                TextInputField(
                  onChange: (value) {
                    args.update('Email', (old) => value!);
                  },
                  label: 'Email',
                  prefixIcon: Icons.email,
                ),

                // Password Input Field
                TextInputField(
                  onChange: (value) {
                    args.update('Password', (old) => value!);
                  },
                  obscureText: true,
                  label: 'Password',
                  prefixIcon: Icons.key,
                ),

                // Password Input Field
                TextInputField(
                  obscureText: true,
                  label: 'Confirm Password',
                  onChange: (value) {
                    args.update('Confirm Password', (old) => value!);
                  },
                  prefixIcon: Icons.password,
                ),

                // margin
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                // Sign in button
                ForwardLabelButton(
                  onPress: () {
                    final name = args['Name'];
                    final email = args['Email'];
                    final password = args['Password'];
                    final confirmPassword = args['Confirm Password'];

                    if (_formKey.currentState!.validate() &&
                        password == confirmPassword) {
                      context.read<AuthBloc>().add(
                            AuthEventSignUp(
                              name: name,
                              email: email,
                              password: password,
                            ),
                          );
                    }
                  },
                  label: 'Sign Up',
                ),
              ],
            ),
          )),
    );
  }
}
