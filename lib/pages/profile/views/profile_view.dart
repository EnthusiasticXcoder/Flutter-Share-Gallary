import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/loading_screen.dart';
import 'package:gallary/helpers/message_box.dart';
import 'package:gallary/helpers/profile/profile_pic.dart';
import 'package:gallary/helpers/shaders/circle_shader.dart';
import 'package:gallary/services/auth/auth.dart';
import 'package:gallary/services/auth/auth_user.dart';
import 'package:gallary/services/auth/profile/profile_bloc.dart';
import 'package:image_picker/image_picker.dart' show ImageSource;

import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().showLoadingScreen(context);
        } else {
          LoadingScreen().hideLoadingScreen(context);
        }
        if (state.message != null) {
          MessageBox.showMessage(context, state.message!);
        }
        if (state is ProfileStateExit) {
          if (!state.isLoggedin) {
            context.read<AuthBloc>().add(
                  const AuthEventInitialise(),
                );
          }
          final navigator = Navigator.of(context);
          navigator.popUntil((route) => !navigator.canPop());
        } else if (state is ProfileStateShowProfilePic) {
          ProfilePicture.showDialog(
            context,
            state.imageURI,
            Icons.person,
            onDeletePic: () {
              Navigator.pop(context);
              context.read<ProfileBloc>().add(
                    const ProfileEventUpdateProfile(deleteImage: true),
                  );
            },
            oncameraPic: () {
              Navigator.pop(context);
              context.read<ProfileBloc>().add(
                    const ProfileEventUpdateProfile(source: ImageSource.camera),
                  );
            },
            onGallaryPic: () {
              Navigator.pop(context);
              context.read<ProfileBloc>().add(
                    const ProfileEventUpdateProfile(
                        source: ImageSource.gallery),
                  );
            },
          );
        } else if (state is ProfileStateShowMenu) {
          ProfileMenu.showMenu(context);
        } else if (state is ProfileStateDeleteUser) {
          DeleteDialog.showDialog(context);
        } else if (state is ProfileStateChangePassword) {
          ChangePassword.showDialog(context);
        }
      },
      child: Scaffold(
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
                  context.read<ProfileBloc>().add(
                        const ProfileEventShowMenu(),
                      );
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
        body: SafeArea(
          child: CustomPaint(
            painter: BlueCirclePainter(),
            child: Column(
              children: <Widget>[
                // upper margin
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                // Profile Picture Widget
                StreamBuilder<AuthUser>(
                    stream:
                        context.select((ProfileBloc bloc) => bloc.userChange),
                    builder: (context, snapshot) {
                      return Hero(
                        tag: 'User Profile',
                        child: GestureDetector(
                          onTap: () {
                            context.read<ProfileBloc>().add(
                                  ProfileEventShowProfilePic(
                                      snapshot.data?.photo),
                                );
                          },
                          child: CircleAvatar(
                            radius:
                                (MediaQuery.sizeOf(context).width * 0.3 < 120.0)
                                    ? MediaQuery.sizeOf(context).width * 0.3
                                    : 120.0,
                            foregroundImage: (snapshot.data?.photo != null)
                                ? NetworkImage(snapshot.data!.photo!)
                                : null,
                            child: const Icon(
                              Icons.person,
                              size: 170.0,
                            ),
                          ),
                        ),
                      );
                    }),
                // margin
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                // Email label
                FutureBuilder(
                    future:
                        context.select((ProfileBloc bloc) => bloc.currentUser),
                    builder: (context, snapshots) =>
                        Text(snapshots.data?.email ?? '')),
                // user Values container

                FutureBuilder(
                  future:
                      context.select((ProfileBloc bloc) => bloc.currentUser),
                  builder: (context, snapshots) {
                    if (snapshots.hasData) {
                      return ValueBox(user: snapshots.data);
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
