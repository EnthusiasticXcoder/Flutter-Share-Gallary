import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/message_box.dart';
import 'package:gallary/pages/auth/widget/widget.dart';
import 'package:gallary/services/auth/auth.dart';

class GoogleSigninView extends StatelessWidget {
  final List<String> passwordcontainer = ['', ''];
  final _formKey = GlobalKey<FormState>();
  GoogleSigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return PaintedScaffold(
      relBoxheight: 0.35,
      title: 'Google SignIn',
      onBack: () {
        context.read<AuthBloc>().add(
              const AuthEventLogout(),
            );
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (didpop) {
          context.read<AuthBloc>().add(
                const AuthEventLogout(),
              );
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextInputField(
                label: 'Enter Password',
                onChange: (value) {
                  passwordcontainer.removeAt(0);
                  passwordcontainer.insert(0, value!);
                },
              ),

              // margin
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              TextInputField(
                label: 'Confirm Password',
                onChange: (value) {
                  passwordcontainer.removeAt(1);
                  passwordcontainer.insert(1, value!);
                },
              ),

              // margin
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              // Send mail Button
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String password = passwordcontainer.first;
                      String confirmPassword = passwordcontainer.last;
                      if (password == confirmPassword) {
                        context.read<AuthBloc>().add(
                              AuthEventGoogleSignUp(password: password),
                            );
                      } else {
                        MessageBox.showMessage(
                          context,
                          'Password and Confirm Password Should Be same',
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      minimumSize: Size(double.maxFinite,
                          MediaQuery.of(context).size.height * 0.055),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0))),
                  child: const Text('Sign In')),
            ],
          ),
        ),
      ),
    );
  }
}
