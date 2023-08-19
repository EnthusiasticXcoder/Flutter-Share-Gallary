import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/pages/auth/auth.dart';
import 'package:gallary/pages/auth/view/forgot_password_view.dart';
import 'package:gallary/pages/home/home.dart';
import 'package:gallary/services/cloud/bloc/cloud_bloc.dart';

import 'services/auth/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialise());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case AuthLoggedIn:
            return BlocProvider(
              create: (context) => CloudBloc(),
              child: const HomeView(),
            );
          case AuthSignIn:
            return const SignInView();
          case AuthSignUp:
            return const SignUpView();
          case AuthAuthoriseUser:
            return const VerificationView();
          case AuthForgotPassword:
            return ForgotPasswordView();
          case AuthWelcome:
            return const WelcomeView();
          default:
            return const Scaffold();
        }
      },
    );
  }
}
