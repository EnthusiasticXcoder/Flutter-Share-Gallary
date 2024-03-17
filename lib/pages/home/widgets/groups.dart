import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/profile/profile_pic.dart';
import 'package:gallary/pages/home/widgets/add_group.dart';

import 'package:gallary/routs/app_routs.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CloudBloc, CloudState>(
      listener: (context, state) {
        if (state is CloudStateCreateGroup) {
          AddGroupBottomSheet.showAddBottomSheet(context);
        } else if (state is CloudStateGroupAdded) {
          AddGroupBottomSheet.showAddedBottomSheet(context, state.id);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<CloudBloc>().add(
                  const CloudEventAddAGroup(),
                );
          },
          backgroundColor: Colors.lightBlueAccent,
          elevation: 10,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.group_add,
            size: 25,
          ),
        ),
        body: StreamBuilder<Iterable<Stream<GroupData>>>(
          stream: context.select((CloudBloc bloc) => bloc.allUserGroups),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final groupList = snapshot.data;
              return ListView.builder(
                itemCount: groupList?.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => StreamBuilder<GroupData>(
                  stream: groupList?.elementAt(index),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return groupTile(context, snapshot.data);
                    } else {
                      // loading screen
                      return const ListTile(tileColor: Colors.grey);
                    }
                  },
                ),
              );
            } else {
              // circular progress
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  ListTile groupTile(BuildContext context, GroupData? groupData) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRouts.groupPage,
          arguments: groupData,
        );
      },
      leading: InkWell(
        onTap: () {
          // showDialog(
          //   context: context,
          //   builder: (context) => const ProfilePicture(),
          // );

          ProfilePicture.showImageView(
            context,
            groupData.imageURL,
            Icons.group,
          );
        },
        child: Hero(
          tag: groupData!.id,
          child: CircleAvatar(
            foregroundImage: (groupData.imageURL == null)
                ? null
                : NetworkImage(groupData.imageURL!),
            child: const Icon(Icons.group),
          ),
        ),
      ),
      title: Text(
        groupData.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(groupData.info),
      trailing: Text(formateDate(groupData.dateTime)),
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
          .join(':');
    }
  }
}
