import 'package:flutter/material.dart';

import '../widget/widget.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return PaintedScaffold(
      title: 'Sign In',
      relBoxheight: 0.385,
      child: Column(
        children: <Widget>[
          // Name or Email Input Field
          const TextInputField(
            label: 'Name or Email',
            prefixIcon: Icons.email,
          ),
          // margin
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          // Password Input Field
          const TextInputField(
            label: 'Password',
            prefixIcon: Icons.key,
            suffixIcon: Icons.remove_red_eye,
          ),

          // margin
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          // Sign in button
          ForwardLabelButton(
            onPress: () {},
            label: 'Sign In',
          ),
        ],
      ),
    );
  }
}
