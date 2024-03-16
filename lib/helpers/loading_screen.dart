import 'package:flutter/material.dart';

class LoadingScreen {
  bool isLoading = false;
  static final _share = LoadingScreen._instance();
  LoadingScreen._instance();
  factory LoadingScreen() => _share;

  void hideLoadingScreen(BuildContext context) {
    final navigator = Navigator.of(context);
    if (isLoading) navigator.pop();
    isLoading = false;
  }

  Future<void> showLoadingScreen(BuildContext context) async {
    isLoading = true;
    await showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.sizeOf(context);
        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                height: size.height * 0.15,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Loading, Please Wait!'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
