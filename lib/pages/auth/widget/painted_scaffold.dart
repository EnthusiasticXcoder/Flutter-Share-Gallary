import 'package:flutter/material.dart';
import 'package:gallary/helpers/shaders/circle_shader.dart';

class PaintedScaffold extends StatelessWidget {
  final double relBoxheight;
  final Widget? child;
  final Widget? bottom;
  final String? title;
  final String? label;
  final VoidCallback? onBack;
  const PaintedScaffold({
    super.key,
    this.relBoxheight = 0.5,
    this.child,
    this.title,
    this.label,
    this.onBack,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 231, 242, 249),
      appBar: (title == null)
          ? null
          : AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              leading: BackButton(onPressed: onBack),
              title: SafeArea(child: Text(title!)),
              centerTitle: true,
            ),
      body: CustomPaint(
        painter: BlueCirclePainter(),
        child: Column(
          mainAxisAlignment: (label == null)
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            // margin
            SizedBox(
                height: (label == null)
                    ? null
                    : MediaQuery.of(context).size.height * 0.05),
            // Information Label
            if (label != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            // margin
            SizedBox(
                height: (label == null)
                    ? null
                    : MediaQuery.of(context).size.height * 0.15),

            // Data Holding Container
            Container(
                height: MediaQuery.of(context).size.height * relBoxheight,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.height * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.06,
                    vertical: MediaQuery.of(context).size.height * 0.035),
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
                child: child),
            // widget in the bottom of the container
            if (bottom != null) bottom!,
          ],
        ),
      ),
    );
  }
}
