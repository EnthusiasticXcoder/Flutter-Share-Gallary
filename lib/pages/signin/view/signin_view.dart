import 'package:flutter/material.dart';
import 'package:gallary/helpers/shaders/circle_shader.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 231, 242, 249),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          title: const SafeArea(child: Text('Sign In')),
          centerTitle: true,
        ),
        body: CustomPaint(
            painter: BlueCirclePainter(),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.385,
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
                child: Column(children: <Widget>[
                  // Name or Email Input Field
                  TextField(
                    //controller: _nameController,
                    style: const TextStyle(color: Colors.blueGrey),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      label: const Text('Name or Email'),
                      fillColor: Colors.grey.shade50,
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  // margin
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  // Password Input Field
                  TextField(
                    //controller: _nameController,
                    style: const TextStyle(color: Colors.blueGrey),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.key),
                      suffixIcon: const Icon(Icons.remove_red_eye),
                      label: const Text('Password'),
                      fillColor: Colors.grey.shade50,
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.blueGrey),
                    ),
                  ),

                  // margin
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  // Sign in button
                  ListTile(
                    title: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          fixedSize: const Size.fromRadius(24),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward,
                        )),
                  )
                ]),
              ),
            )));
  }
}
