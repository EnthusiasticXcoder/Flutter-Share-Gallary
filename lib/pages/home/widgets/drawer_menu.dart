import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/shaders/circle_shader.dart';
import 'package:gallary/routs/app_routs.dart';
import 'package:gallary/services/auth/auth_user.dart';
import 'package:gallary/services/auth/bloc/auth_bloc.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

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
            StreamBuilder<AuthUser?>(
                stream: context.select((CloudBloc bloc) => bloc.userChange),
                builder: (context, snapshot) {
                  return infoTile(
                    context,
                    name: snapshot.data?.name,
                    email: snapshot.data?.email,
                    image: snapshot.data?.photo,
                  );
                }),
            // divider
            const Divider(color: Colors.white24),
            // backup button
            menuTile(
              icon: const Icon(Icons.backup_rounded),
              title: const Text('Backup'),
              subtitle: StreamBuilder<Iterable<ImageData>>(
                  stream: context.select((CloudBloc bloc) => bloc.allImages),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final sync = snapshot.data!
                          .where((element) => !element.isSync)
                          .length;
                      return Text('$sync UnBackuped Files Found');
                    } else {
                      return const Text('');
                    }
                  }),
              onPress: () {
                print('object =====================');
                // Navigator.pushNamed(context, AppRouts.backupPage);
              },
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
    required String? name,
    required String? email,
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
        title: Text(name ?? ''),
        subtitle: Text(
          email ?? '',
          overflow: TextOverflow.ellipsis,
        ),
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

class BackupView extends StatelessWidget {
  const BackupView({super.key});

  @override
  Widget build(BuildContext context) {
    int value = 4;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: CustomPaint(
        painter: BlueCirclePainter(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: StatefulBuilder(builder: (context, setState) {
                return Column(
                  children: [
                    RadioListTile(
                      value: 1,
                      groupValue: value,
                      onChanged: (newvalue) => setState(
                        () => value = newvalue!,
                      ),
                      title: const Text('Daily'),
                    ),
                    RadioListTile(
                      value: 2,
                      groupValue: value,
                      onChanged: (newvalue) => setState(
                        () => value = newvalue!,
                      ),
                      title: const Text('Weekely'),
                    ),
                    RadioListTile(
                      value: 3,
                      groupValue: value,
                      onChanged: (newvalue) => setState(
                        () => value = newvalue!,
                      ),
                      title: const Text('Monthly'),
                    ),
                    RadioListTile(
                      value: 4,
                      groupValue: value,
                      onChanged: (newvalue) => setState(
                        () => value = newvalue!,
                      ),
                      title: const Text('Never'),
                    ),
                  ],
                );
              }),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                horizontalTitleGap: 0,
                title: const Text('Items To BackUp, Backup Now!'),
                subtitle: StreamBuilder<Iterable<ImageData>>(
                    stream: context.select((CloudBloc bloc) => bloc.allImages),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        final sync = data
                            .where((element) => element.isSync == true)
                            .length;
                        return Text('$sync/${data.length}');
                      } else {
                        return const Text('--/--');
                      }
                    }),
                trailing: TextButton(
                  onPressed: () {
                    context.read<CloudBloc>().add(
                          const CloudEventBackupImages(),
                        );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green.shade800,
                  ),
                  child: const Text('BackUp'),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: BlocBuilder<CloudBloc, CloudState>(
                  buildWhen: (previous, current) =>
                      current is CloudStateUploadTask,
                  builder: (context, state) {
                    if (state is CloudStateUploadTask) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: Text(state.progress),
                            title: Text(state.imageData.title ?? ''),
                            subtitle: StreamBuilder<TaskSnapshot>(
                                stream: state.task,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return LinearProgressIndicator(
                                      value: (snapshot.data!.bytesTransferred /
                                          snapshot.data!.totalBytes),
                                      color: Colors.green,
                                    );
                                  } else {
                                    return const LinearProgressIndicator(
                                      value: 0.01,
                                      color: Colors.green,
                                    );
                                  }
                                }),
                            trailing: Text(
                                '${((state.imageData.size ?? 0) / (1024 * 1024)).toStringAsFixed(2)}MB'),
                          ),
                          Container(
                            height: (state.imageData.height ?? 40) / 2.5,
                            width: (state.imageData.width ?? 80) / 2.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                  image: PhotoProvider(
                                      mediumId: state.imageData.id),
                                  fit: BoxFit.fill),
                            ),
                          )
                        ],
                      );
                    } else {
                      return const Center(
                          child: Text('No Backup Task In Progress'));
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
