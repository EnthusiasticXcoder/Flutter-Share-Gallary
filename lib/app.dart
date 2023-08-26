import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/loading_screen.dart';
import 'package:gallary/services/auth/auth_service.dart';

import 'helpers/message_box.dart';
import 'pages/auth/auth.dart';
import 'pages/home/home.dart';
import 'services/auth/auth.dart';
import 'services/cloud/bloc/cloud_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(
          const AuthEventInitialise(),
        );
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().showLoadingScreen(context);
        } else {
          LoadingScreen().hideLoadingScreen(context);
        }
        if (state.exception != null) {
          final message = state.exception?.message;
          MessageBox.showMessage(context, message!);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AuthLoggedIn:
            return BlocProvider(
              create: (context) => CloudBloc(AuthService.firebase()),
              child: const HomeView(),
            );
          case AuthSignIn:
            return SignInView();
          case AuthSignUp:
            return SignUpView();
          case AuthAuthoriseUser:
            return const VerificationView();
          case AuthForgotPassword:
            return ForgotPasswordView();
          case AuthLoggedout:
            return const WelcomeView();
          default:
            return const Scaffold();
        }
      },
    );
  }
}
