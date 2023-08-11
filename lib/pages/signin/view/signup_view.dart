import 'package:flutter/material.dart';
import 'package:gallary/helpers/shaders/circle_shader.dart';
import 'package:gallary/pages/signin/view/verification_view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 231, 242, 249),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          title: const SafeArea(child: Text('Sign Up')),
          centerTitle: true,
        ),
        body: CustomPaint(
            painter: BlueCirclePainter(),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.57,
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
                  // Name Input Field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // First Name
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextField(
                          //controller: _nameController,
                          style: const TextStyle(color: Colors.blueGrey),
                          decoration: InputDecoration(
                            label: const Text('First Name'),
                            fillColor: Colors.grey.shade50,
                            filled: true,
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      // Last Name
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextField(
                          //controller: _nameController,
                          style: const TextStyle(color: Colors.blueGrey),
                          decoration: InputDecoration(
                            label: const Text('Last Name'),
                            fillColor: Colors.grey.shade50,
                            filled: true,
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // margin
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // Email Input Field
                  TextField(
                    //controller: _nameController,
                    style: const TextStyle(color: Colors.blueGrey),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      label: const Text('Email'),
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
                      label: const Text('Password'),
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
                      prefixIcon: const Icon(Icons.password),
                      label: const Text('Confirm Password'),
                      fillColor: Colors.grey.shade50,
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  // margin
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  // Sign in button
                  ListTile(
                    title: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          fixedSize: const Size.fromRadius(24),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const VerificationView(),
                          ));
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                        )),
                  )
                ]),
              ),
            )));
  }
}
