import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/image/image_grid.dart';
import 'package:gallary/routs/app_routs.dart';
import 'package:gallary/services/cloud/cloud.dart';

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
          padding: const EdgeInsets.only(bottom: 80),
          child: StreamBuilder<Iterable<GroupImage>>(
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
                              child: Text(item.data),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              FutureBuilder<MembersData>(
                                  future: item.senderInfo,
                                  builder: (context, snapshot) {
                                    return ListTile(
                                      leading: InkWell(
                                        onTap: () {},
                                        child: CircleAvatar(
                                          foregroundImage:
                                              (snapshot.data?.imageURL == null)
                                                  ? null
                                                  : NetworkImage(
                                                      snapshot.data!.imageURL!),
                                          child: const Icon(Icons.person),
                                        ),
                                      ),
                                      title: Text(
                                        snapshot.data!.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(snapshot.data!.info),
                                      trailing:
                                          Text(item.date.toIso8601String()),
                                    );
                                  }),
                              ImageGrid(
                                images: item.data, //---------------------------
                              ),
                            ],
                          ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SendImageTextField(
        onSelectGallary: () async {
          final Iterable<ImageData> images = [];
          // Navigator.of(context).pushNamed(
          //   AppRouts.selectionView,
          //   arguments: {
          //     'Images': images,
          //     'Image': null,
          //     'onSelect': () {
          //       Navigator.pop(context);
          //       context.read<CloudBloc>().add(
          //             const CloudEventInitial(),
          //           );
          //     }
          //   },
          // );
        },
      ),
    );
  }
}

class SendImageTextField extends StatelessWidget {
  final VoidCallback onSelectGallary;
  const SendImageTextField({super.key, required this.onSelectGallary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: TextField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              hintText: 'Message',
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // camera icon button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      size: 27,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),

                  // image selector icon button
                  IconButton(
                    onPressed: onSelectGallary,
                    icon: Icon(
                      Icons.image_rounded,
                      size: 27,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // send button
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.lightBlueAccent.shade200,
          shape: const CircleBorder(),
          child: const Icon(Icons.send),
        )
      ],
    );
  }
}
