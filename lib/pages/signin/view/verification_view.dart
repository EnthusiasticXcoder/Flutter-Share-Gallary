import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallary/helpers/shaders/circle_shader.dart';
import 'package:gallary/pages/home/home.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 242, 249),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          title: const SafeArea(child: Text('Email Verification')),
          centerTitle: true,
        ),
        body: CustomPaint(
            painter: BlueCirclePainter(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // margin
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                // Information Label
                const Text(
                  'We Have Sent A Email Verification OTP To Your Mail Account Example.123@gmail.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
                // margin
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                // Container
                Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.02),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.06,
                        vertical: MediaQuery.of(context).size.height * 0.03),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Row>[
                        // OTP Holder
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <OTPEntry>[
                            // first
                            OTPEntry(
                              onChange: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                            // second
                            OTPEntry(onChange: (value) {
                              if (value.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              } else if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            }),
                            // third
                            OTPEntry(
                              onChange: (value) {
                                if (value.isEmpty) {
                                  FocusScope.of(context).previousFocus();
                                } else if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                            // fourth
                            OTPEntry(onChange: (value) {
                              if (value.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                              if (value.length == 1) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const HomeView(),
                                    ),
                                    (route) => false);
                              }
                            }),
                          ],
                        ),

                        // resend text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Didn\'t Recieve Code?'),
                            TextButton(
                                onPressed: () {},
                                child: const Text('Resend Code'))
                          ],
                        ),
                      ],
                    )),
              ],
            )));
  }
}

typedef ValueCallBack = void Function(String);

class OTPEntry extends StatelessWidget {
  final ValueCallBack onChange;
  const OTPEntry({
    super.key,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        onChanged: onChange,
        showCursor: false,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
