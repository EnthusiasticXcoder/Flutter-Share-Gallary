import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/image/image_grid.dart';
import 'package:gallary/routs/app_routs.dart';

import '../../../services/cloud/bloc/bloc.dart';
import '../widgets/widgets.dart';

class GroupView extends StatelessWidget {
  final String groupId;
  const GroupView({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade400,
      appBar: GroupInfoAppBar(
        stream: context.select((CloudBloc bloc) => bloc.getGroupData(groupId)),
        groupId: groupId,
        onPress: () {
          Navigator.of(context).pushNamed(
            AppRouts.groupDetailsPage,
            arguments: groupId,
          );
        },
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
