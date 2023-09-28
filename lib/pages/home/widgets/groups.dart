import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/profile/profile_pic.dart';

import 'package:gallary/routs/app_routs.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<Future<GroupData>>>(
      stream: context.select((CloudBloc bloc) => bloc.allUserGroups),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final groupList = snapshot.data;
          return ListView.builder(
            itemCount: groupList?.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => FutureBuilder<GroupData>(
              future: groupList?.elementAt(index),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final groupData = snapshot.data;

                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouts.groupPage,
                          arguments: groupData?.id);
                    },
                    leading: InkWell(
                      onTap: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (context) => const ProfilePicture(),
                        // );

                        ProfilePicture.showImageView(
                            context, groupData?.imageURL, Icons.group);
                      },
                      child: CircleAvatar(
                        foregroundImage: (groupData?.imageURL == null)
                            ? null
                            : NetworkImage(groupData!.imageURL!),
                        child: const Icon(Icons.group),
                      ),
                    ),
                    title: Text(
                      groupData?.name ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(groupData?.info ?? ''),
                    trailing: Text(formateDate(groupData?.dateTime)),
                  );
                } else {
                  // loading screen
                  return Container();
                }
              },
            ),
          );
        } else {
          // circular progress
          return Container();
        }
      },
    );
  }

  String formateDate(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    } else {
      return dateTime
          .toIso8601String()
          .splitMapJoin(
            'T',
            onMatch: (p0) => '\n',
          )
          .split(':')
          .sublist(0, 2)
          .join();
    }
  }
}
