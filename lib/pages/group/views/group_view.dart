import 'package:flutter/material.dart';
import 'package:gallary/helpers/image/image_grid.dart';
import 'package:gallary/routs/app_routs.dart';

class GroupView extends StatelessWidget {
  const GroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade400,
      appBar: AppBar(
        leadingWidth: 20.0,
        title: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(AppRouts.groupDetailsPage);
          },
          minLeadingWidth: 0.0,
          leading: const Hero(
            tag: 'CircularProfileIcon',
            child: CircleAvatar(
              child: Icon(Icons.group),
            ),
          ),
          title: const Text(
            'Group Name',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 15, color: Colors.white),
          ),
          subtitle: const Text(
            'Subtitle Text For The Group',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        toolbarHeight: 90,
        iconTheme: const IconThemeData(size: 30, color: Colors.white),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      ),
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
