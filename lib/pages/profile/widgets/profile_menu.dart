import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/profile/show_image_picker.dart';
import 'package:gallary/services/auth/profile/profile_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart' show ImageSource;

class ProfileMenu {
  ProfileMenu.showMenu(BuildContext context) {
    showMenu(
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      context: context,
      position: RelativeRect.fromLTRB(MediaQuery.of(context).size.width * 0.13,
          0, MediaQuery.of(context).size.width * 0.12, 0),
      items: <PopupMenuItem>[
        // change profile pic
        PopupMenuItem(
          onTap: () {
            showImagePicker(
              context: context,
              onDeletePic: () {
                Navigator.pop(context);
                context.read<ProfileBloc>().add(
                      const ProfileEventUpdateProfile(deleteImage: true),
                    );
              },
              oncameraPic: () {
                Navigator.pop(context);
                context.read<ProfileBloc>().add(
                      const ProfileEventUpdateProfile(
                          source: ImageSource.camera),
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
          },
          child: const Row(
            children: <Widget>[
              Icon(Icons.edit),
              SizedBox(width: 8.0),
              Text('Change Profile Picture'),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            context.read<ProfileBloc>().add(
                  const ProfileEventChangePassword(),
                );
          },
          child: const Row(
            children: <Widget>[
              Icon(Icons.change_circle),
              SizedBox(width: 8.0),
              Text('Change Password'),
            ],
          ),
        ),

        PopupMenuItem(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut().then((value) {
              context.read<ProfileBloc>().add(
                    const ProfileEventExit(isLoggedIn: false),
                  );
            });
          },
          child: const Row(
            children: <Widget>[
              Icon(Icons.logout),
              SizedBox(width: 8.0),
              Text('Log Out'),
            ],
          ),
        ),

        PopupMenuItem(
          onTap: () {
            context.read<ProfileBloc>().add(
                  const ProfileEventDeleteUser(),
                );
          },
          child: const Row(
            children: <Widget>[
              Icon(Icons.delete_forever),
              SizedBox(width: 8.0),
              Text('Delete Account'),
            ],
          ),
        ),
      ],
    ).then((value) => context.read<ProfileBloc>().add(
          const ProfileEventInitial(),
        ));
  }
}
