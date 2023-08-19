import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/routs/app_routs.dart';
import 'package:gallary/services/auth/bloc/auth_bloc.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // margin
            SizedBox(height: height * 0.05),
            // user details and profile
            infoTile(
              context,
              name: 'User Name',
              email: 'example124@gmail.com',
            ),
            // divider
            const Divider(color: Colors.white24),
            // backup button
            menuTile(
              icon: const Icon(Icons.backup_rounded),
              title: const Text('Backup'),
            ),
            // Account Storage
            menuTile(
              icon: const Icon(Icons.memory_rounded),
              title: const Text('Account Storage'),
              subtitle: const LinearProgressIndicator(
                value: 0.9,
                color: Colors.green,
              ),
            ),
            // Delete Backuped images
            menuTile(
              icon: const Icon(Icons.delete_forever),
              title: const Text('Free Up Space'),
              traling: const Text('5.3 GB'),
            ),
            // Storage Location
            menuTile(
              icon: const Icon(Icons.storage_rounded),
              title: const Text('Storage Location'),
              subtitle: const Text(
                'Storage/to/download/the/images',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile infoTile(
    BuildContext context, {
    required String name,
    required String email,
    String? image,
  }) =>
      ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRouts.profileView,
            arguments: BlocProvider.of<AuthBloc>(context),
          );
        },
        textColor: Colors.white,
        leading: Hero(
          tag: 'User Profile',
          child: CircleAvatar(
            foregroundImage: (image != null) ? NetworkImage(image) : null,
            child: const Icon(Icons.person),
          ),
        ),
        title: Text(name),
        subtitle: Text(email),
      );

  ListTile menuTile({
    required Widget icon,
    required Widget? title,
    Widget? subtitle,
    Widget? traling,
    VoidCallback? onPress,
  }) {
    return ListTile(
      onTap: onPress,
      iconColor: Colors.white,
      textColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: icon,
      ),
      title: title,
      subtitle: subtitle,
      trailing: traling,
    );
  }
}
