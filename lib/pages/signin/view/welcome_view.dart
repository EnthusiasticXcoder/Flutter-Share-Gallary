import 'package:flutter/material.dart';
import 'package:gallary/helpers/shaders/circle_shader.dart';
import 'package:gallary/pages/signin/view/signIn_view.dart';

import 'signup_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 231, 242, 249),
      body: CustomPaint(
        painter: BlueCirclePainter(),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.02),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06,
                vertical: MediaQuery.of(context).size.height * 0.05),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color.fromARGB(255, 240, 248, 251),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: -1.0,
                    blurRadius: 10.0,
                    offset: Offset(5.0, 5.0),
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: -1.0,
                    blurRadius: 10.0,
                    offset: Offset(-3.0, -3.0),
                  ),
                ]),
            child: Column(children: [
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignInView(),
                    ));
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpView(),
                    ));
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
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata),
                  label: const Text('Sign In with Google'))
            ]),
          ),
        ),
      ),
    );
  }
}
