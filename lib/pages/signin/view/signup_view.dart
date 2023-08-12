import 'package:flutter/material.dart';

import 'package:gallary/pages/signin/view/verification_view.dart';
import 'package:gallary/pages/signin/widget/widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return PaintedScaffold(
        title: 'Sign Up',
        relBoxheight: 0.57,
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
            const TextInputField(label: 'Password', prefixIcon: Icons.key),
            // margin
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            // Password Input Field
            const TextInputField(
                label: 'Confirm Password', prefixIcon: Icons.password),
            // margin
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            // Sign in button
            ForwardLabelButton(
              onPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const VerificationView(),
                ));
              },
              label: 'Sign Up',
            ),
          ],
        ));
  }
}
