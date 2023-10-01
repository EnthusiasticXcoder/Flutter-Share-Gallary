import 'package:flutter/material.dart';
import 'package:gallary/services/cloud/bloc/cloud_bloc.dart';

class GroupInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GroupInfoAppBar({
    super.key,
    required this.groupId,
    required this.onPress,
    required this.stream,
  });

  final Stream<GroupData> stream;
  final VoidCallback onPress;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: TextButton(
        onPressed: () => Navigator.pop(context),
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 5.0)),
        child: Row(
          children: <Widget>[
            const BackButtonIcon(),
            StreamBuilder<GroupData>(
                stream: stream,
                builder: (context, snapshot) {
                  return Hero(
                    tag: 'CircularProfileIcon',
                    child: CircleAvatar(
                      foregroundImage: (snapshot.data?.imageURL != null)
                          ? NetworkImage(snapshot.data!.imageURL!)
                          : null,
                      child: const Icon(Icons.group),
                    ),
                  );
                })
          ],
        ),
      ),
      leadingWidth: 80,
      title: StreamBuilder<GroupData>(
          stream: stream,
          builder: (context, snapshot) {
            return ListTile(
              shape: const StadiumBorder(),
              onTap: onPress,
              title: Text(
                snapshot.data?.name ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                snapshot.data?.info ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            );
          }),
      toolbarHeight: 90,
      iconTheme: const IconThemeData(size: 30, color: Colors.white),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 90);
}
