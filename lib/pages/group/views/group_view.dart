import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/image/image_grid.dart';
import 'package:gallary/routs/app_routs.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart';

class GroupView extends StatelessWidget {
  final String groupId;
  const GroupView({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade400,
      appBar: GroupInfoAppBar(groupId: groupId),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ImageGrid(
            images: [], //          ---------------------------
          ),
        ),
      ),
    );
  }
}

class GroupInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GroupInfoAppBar({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: TextButton(
        onPressed: () => Navigator.pop(context),
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 5.0)),
        child: const Row(
          children: <Widget>[
            BackButtonIcon(),
            Hero(
              tag: 'CircularProfileIcon',
              child: CircleAvatar(
                child: Icon(Icons.group),
              ),
            )
          ],
        ),
      ),
      leadingWidth: 80,
      title: StreamBuilder<GroupData>(
          stream:
              context.select((CloudBloc bloc) => bloc.getGroupData(groupId)),
          builder: (context, snapshot) {
            return ListTile(
              shape: const StadiumBorder(),
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRouts.groupDetailsPage,
                  arguments: groupId,
                );
              },
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
