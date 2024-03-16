import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/profile/profile_pic.dart';
import 'package:gallary/helpers/profile/show_image_picker.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

class GroupDetails extends StatelessWidget {
  final GroupData groupData;
  const GroupDetails({super.key, required this.groupData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <IconButton>[
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // margin
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01),
                      const Text(
                        'GroupId',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      // margin
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01),
                      TextFormField(
                        initialValue: groupData.id,
                        readOnly: true,
                      ),

                      // margin
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.05),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.qr_code_2),
          ),
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
                items: <PopupMenuItem>[
                  // change profile pic
                  PopupMenuItem(
                    onTap: () {
                      showImagePicker(
                        context: context,
                        onDeletePic: () {
                          Navigator.pop(context);
                          context.read<CloudBloc>().add(
                                CloudEventUpdateGroupProfile(
                                  groupId: groupData.id,
                                  deleteImage: true,
                                ),
                              );
                        },
                        oncameraPic: () {
                          context.read<CloudBloc>().add(
                                CloudEventUpdateGroupProfile(
                                  groupId: groupData.id,
                                  source: ImageSource.camera,
                                ),
                              );
                        },
                        onGallaryPic: () {
                          context.read<CloudBloc>().add(
                                CloudEventUpdateGroupProfile(
                                  groupId: groupData.id,
                                  source: ImageSource.gallery,
                                ),
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
                      final formkey = GlobalKey<FormState>();
                      String? groupName;
                      String? groupInfo;
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Edit Group'),
                          content: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // margin
                                SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.01),
                                // confirm new password field
                                TextFormField(
                                  decoration: const InputDecoration(
                                      label: Text('Group Name')),
                                  onChanged: (value) => groupName = value,
                                  validator: (value) =>
                                      (value == null || value.isEmpty)
                                          ? 'Required Field'
                                          : null,
                                ), // margin
                                SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.01),
                                // confirm new password field
                                TextFormField(
                                  decoration: const InputDecoration(
                                      label: Text('Group Info')),
                                  onChanged: (value) => groupInfo = value,
                                  validator: (value) =>
                                      (value == null || value.isEmpty)
                                          ? 'Required Field'
                                          : null,
                                ),
                              ],
                            ),
                          ),
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          actions: <ElevatedButton>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Clear'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                if (formkey.currentState!.validate()) {
                                  context.read<CloudBloc>().add(
                                        CloudEventUpdateGroupData(
                                          groupId: groupData.id,
                                          groupName: groupName,
                                          groupInfo: groupInfo,
                                        ),
                                      );
                                }
                              },
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Row(
                      children: <Widget>[
                        Icon(Icons.edit_document),
                        SizedBox(width: 8.0),
                        Text('Edit Group'),
                      ],
                    ),
                  ),
                  (groupData.isUserAdmin)
                      ? PopupMenuItem(
                          onTap: () {
                            context.read<CloudBloc>().add(
                                  CloudEventDeleteGroup(groupData.id),
                                );

                            final navigator = Navigator.of(context);

                            navigator.popUntil((route) => !navigator.canPop());
                          },
                          child: const Row(
                            children: <Widget>[
                              Icon(Icons.delete_forever),
                              SizedBox(width: 8.0),
                              Text('Delete Group'),
                            ],
                          ),
                        )
                      : PopupMenuItem(child: Container()),
                ],
              ).then((value) => context.read<CloudBloc>().add(
                    const CloudEventInitial(),
                  ));
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile Picture Widget
          StreamBuilder<GroupData>(
              stream: context
                  .select((CloudBloc bloc) => bloc.getGroupData(groupData.id)),
              builder: (context, snapshot) => (snapshot.hasData)
                  ? imageDisplay(context, snapshot.data)
                  : imageDisplay(context, groupData)),
          // Margin
          const SizedBox(height: 18),
          // Group Name
          StreamBuilder<GroupData>(
              stream: context
                  .select((CloudBloc bloc) => bloc.getGroupData(groupData.id)),
              builder: (context, snapshot) {
                return Text(
                  snapshot.data?.name ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 26),
                );
              }),
          // Number of Participents
          StreamBuilder<Iterable<Future<MembersData>>>(
              stream: context
                  .select((CloudBloc bloc) => bloc.getMembers(groupData.id)),
              builder: (context, snapshot) {
                return Text(
                  'Group : ${snapshot.data?.length ?? 0} Members',
                  textAlign: TextAlign.center,
                );
              }),
          // Search Participent
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: StreamBuilder<Iterable<Future<MembersData>>>(
                stream: context
                    .select((CloudBloc bloc) => bloc.getMembers(groupData.id)),
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Members NUmber
                      Text('${snapshot.data?.length ?? 0} Members'),
                      // Search Icon Buttton
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      )
                    ],
                  );
                }),
          ),
          // Members List
          Expanded(
            child: StreamBuilder<Iterable<Future<MembersData>>>(
              stream: context
                  .select((CloudBloc bloc) => bloc.getMembers(groupData.id)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final memberList = snapshot.data;
                  return ListView.builder(
                    itemCount: memberList?.length,
                    itemBuilder: (context, index) => FutureBuilder<MembersData>(
                      future: memberList?.elementAt(index),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return memberTile(context, snapshot.data);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          // Delete Group
          TextButton.icon(
            onPressed: () {
              context.read<CloudBloc>().add(
                    CloudEventRemoveGroupMember(groupData.id),
                  );

              final navigator = Navigator.of(context);
              navigator.popUntil((route) => !navigator.canPop());
            },
            label: const Text(
              'Exit Group',
              style: TextStyle(color: Colors.red),
            ),
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  ListTile memberTile(BuildContext context, MembersData? memberData) {
    return ListTile(
      onTap: () {
        // showDialog(
        //   context: context,
        //   builder: (context) => const ProfilePicture(),
        // );

        ProfilePicture.showImageView(
          context,
          memberData.imageURL,
          Icons.person,
        );
      },
      leading: CircleAvatar(
          foregroundImage: (memberData?.imageURL != null)
              ? NetworkImage(memberData!.imageURL!)
              : null,
          child: const Icon(Icons.person_2)),
      title: Text(
        memberData?.name ?? '',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(memberData?.info ?? ''),
      trailing: (memberData!.isAdmin) ? adminTag() : null,
    );
  }

  Container adminTag() {
    return Container(
      width: 60,
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.greenAccent.shade100.withAlpha(70),
      ),
      alignment: Alignment.center,
      child: Text(
        'Admin',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Colors.green.shade800),
      ),
    );
  }

  Hero imageDisplay(BuildContext context, GroupData? groupData) {
    return Hero(
      tag: groupData?.id ?? '',
      child: GestureDetector(
        onTap: () {
          // showDialog(
          //   context: context,
          //   builder: (context) => const ProfilePicture(),
          // );
          if (groupData!.isUserAdmin) {
            ProfilePicture.showDialog(
              context,
              groupData.imageURL,
              Icons.group,
              onDeletePic: () {
                context.read<CloudBloc>().add(
                      CloudEventUpdateGroupProfile(
                        groupId: groupData.id,
                        deleteImage: true,
                      ),
                    );
              },
              oncameraPic: () {
                context.read<CloudBloc>().add(
                      CloudEventUpdateGroupProfile(
                        groupId: groupData.id,
                        source: ImageSource.camera,
                      ),
                    );
              },
              onGallaryPic: () {
                context.read<CloudBloc>().add(
                      CloudEventUpdateGroupProfile(
                        groupId: groupData.id,
                        source: ImageSource.gallery,
                      ),
                    );
              },
            );
          } else {
            ProfilePicture.showImageView(
              context,
              groupData.imageURL,
              Icons.group,
            );
          }
        },
        child: CircleAvatar(
          radius: (MediaQuery.sizeOf(context).width * 0.3 < 120.0)
              ? MediaQuery.sizeOf(context).width * 0.3
              : 120.0,
          foregroundImage: (groupData?.imageURL != null)
              ? NetworkImage(groupData!.imageURL!)
              : null,
          child: const Icon(
            Icons.group,
            size: 170.0,
          ),
        ),
      ),
    );
  }
}
