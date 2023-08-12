import 'package:flutter/material.dart';
import 'package:gallary/helpers/profile/profile_pic.dart';

class GroupDetails extends StatelessWidget {
  const GroupDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        // Profile Picture Widget
        Hero(
          tag: 'CircularProfileIcon',
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
                Icons.group,
                size: 130.0,
              ),
            ),
          ),
        ),
        // Margin
        const SizedBox(height: 18),
        // Group Name
        const Text(
          'Group Name',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        // Number of Participents
        const Text(
          'Group : 15 Members',
          textAlign: TextAlign.center,
        ),
        // Search Participent
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Members NUmber
              const Text('15 Members'),
              // Search Icon Buttton
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
        // Members List
        Expanded(
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const ProfilePicture(),
                );
              },
              leading: const CircleAvatar(child: Icon(Icons.person_2)),
              title: const Text(
                'Member Name',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Subtitle Text For The Member'),
            ),
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
      ]),
    );
  }
}
