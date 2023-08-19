import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/profile/profile_pic.dart';
import 'package:gallary/helpers/shaders/circle_shader.dart';
import 'package:gallary/services/auth/bloc/auth_bloc.dart';

import '../widgets/value_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _infoController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _infoController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 231, 242, 249),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'User Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <IconButton>[
          IconButton(
              onPressed: () {
                showMenu(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    context: context,
                    position: RelativeRect.fromLTRB(
                        MediaQuery.of(context).size.width * 0.13,
                        0,
                        MediaQuery.of(context).size.width * 0.12,
                        0),
                    items: [
                      const PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 8.0),
                            Text('Change Profile Picture'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          context.read<AuthBloc>().add(
                                const AuthEventWelcome(),
                              );
                          final navigator = Navigator.of(context);
                          if (navigator.canPop()) navigator.pop();
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.delete_forever),
                            SizedBox(width: 8.0),
                            Text('Delete Account'),
                          ],
                        ),
                      ),
                    ]);
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
        child: CustomPaint(
          painter: BlueCirclePainter(),
          child: Column(
            children: [
              // upper margin
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              // Profile Picture Widget
              Hero(
                tag: 'User Profile',
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ProfilePicture(),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 90.0,
                    child: Icon(
                      Icons.person,
                      size: 130.0,
                    ),
                  ),
                ),
              ),
              // margin
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              // Email label
              const Text('Example.123@gmail.com'),
              // user Values container
              ValueBox(
                  nameController: _nameController,
                  infoController: _infoController)
            ],
          ),
        ),
      ),
    );
  }
}
