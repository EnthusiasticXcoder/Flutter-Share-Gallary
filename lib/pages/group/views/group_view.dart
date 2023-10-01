import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/image/image_grid.dart';
import 'package:gallary/routs/app_routs.dart';
import 'package:gallary/services/cloud/cloud.dart';

import '../../../services/cloud/bloc/bloc.dart';
import '../widgets/widgets.dart';

class GroupView extends StatelessWidget {
  final GroupData groupData;
  const GroupView({super.key, required this.groupData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade400,
      appBar: GroupInfoAppBar(
        stream:
            context.select((CloudBloc bloc) => bloc.getGroupData(groupData.id)),
        groupId: groupData.id,
        onPress: () {
          Navigator.of(context).pushNamed(
            AppRouts.groupDetailsPage,
            arguments: groupData,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
              stream: context.select(
                  (CloudBloc bloc) => bloc.getGroupImages(groupData.id)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    reverse: true,
                    children: snapshot.data!.map<Widget>((item) {
                      if (item.type == messageType) {
                        return Container(
                          alignment: Alignment.center,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 8.0),
                              child: Text(
                                item.data,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const ImageGrid(
                          images: [], //          ---------------------------
                        );
                      }
                    }).toList(),
                  );
                } else {
                  return Container();
                }
              }),
        ),
      ),
    );
  }
}
