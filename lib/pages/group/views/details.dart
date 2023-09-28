import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart';

class GroupDetails extends StatelessWidget {
  final String groupId;
  const GroupDetails({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile Picture Widget
          StreamBuilder<GroupData>(
              stream: context
                  .select((CloudBloc bloc) => bloc.getGroupData(groupId)),
              builder: (context, snapshot) => imageDisplay(context, snapshot)),
          // Margin
          const SizedBox(height: 18),
          // Group Name
          StreamBuilder<GroupData>(
              stream: context
                  .select((CloudBloc bloc) => bloc.getGroupData(groupId)),
              builder: (context, snapshot) {
                return Text(
                  snapshot.data?.name ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 26),
                );
              }),
          // Number of Participents
          StreamBuilder<Iterable<Future<MembersData>>>(
              stream:
                  context.select((CloudBloc bloc) => bloc.getMembers(groupId)),
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
                    .select((CloudBloc bloc) => bloc.getMembers(groupId)),
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
              stream:
                  context.select((CloudBloc bloc) => bloc.getMembers(groupId)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final memberList = snapshot.data;
                  return ListView.builder(
                    itemCount: memberList?.length,
                    itemBuilder: (context, index) => FutureBuilder<MembersData>(
                      future: memberList?.elementAt(index),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return memberTile(snapshot.data);
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
            onPressed: () {},
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

  ListTile memberTile(MembersData? memberData) {
    return ListTile(
      onTap: () {
        // showDialog(
        //   context: context,
        //   builder: (context) => const ProfilePicture(),
        // );
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

  Hero imageDisplay(BuildContext context, AsyncSnapshot<GroupData> snapshot) {
    return Hero(
      tag: 'CircularProfileIcon',
      child: GestureDetector(
        onTap: () {
          // showDialog(
          //   context: context,
          //   builder: (context) => const ProfilePicture(),
          // );
        },
        child: CircleAvatar(
          radius: (MediaQuery.sizeOf(context).width * 0.3 < 120.0)
              ? MediaQuery.sizeOf(context).width * 0.3
              : 120.0,
          foregroundImage: (snapshot.data?.imageURL != null)
              ? NetworkImage(snapshot.data!.imageURL!)
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
