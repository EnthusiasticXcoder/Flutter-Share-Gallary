import 'package:flutter/material.dart';
import 'package:gallary/pages/group/group.dart';
import 'package:gallary/pages/group/widgets/profile_image.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const GroupView()));
              },
              leading: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ProfilePicture(),
                  );
                },
                child: const CircleAvatar(
                  child: Icon(Icons.group),
                ),
              ),
              title: const Text(
                'Group Name',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Subtitle Text For The Group'),
              trailing: const Text('HH : MM'),
            ),
        itemCount: 5);
  }
}
