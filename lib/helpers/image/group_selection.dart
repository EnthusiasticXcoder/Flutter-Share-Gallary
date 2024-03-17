import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/message_box.dart';
import 'package:gallary/services/cloud/bloc/cloud_bloc.dart';

class GroupSelection extends StatefulWidget {
  const GroupSelection({super.key});

  @override
  State<GroupSelection> createState() => _GroupSelectionState();
}

class _GroupSelectionState extends State<GroupSelection> {
  final List<GroupData> selectedGroup = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          )
        ],
      ),
      body: StreamBuilder<Iterable<Stream<GroupData>>>(
        stream: context.select((CloudBloc bloc) => bloc.allUserGroups),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final groupList = snapshot.data;
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: groupList!
                  .map(
                    (group) => StreamBuilder<GroupData>(
                      stream: group,
                      builder: (context, snapshot) => (snapshot.hasData)
                          ? groupTile(context, snapshot.data)
                          :
                          // loading screen
                          Container(),
                    ),
                  )
                  .toList(),
            );
          } else {
            // circular progress
            return Container();
          }
        },
      ),
      bottomNavigationBar: Visibility(
        visible: selectedGroup.isNotEmpty,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedGroup.map((e) => e.name).join(', '),
                overflow: TextOverflow.fade,
              ),
              IconButton(
                style: IconButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: const CircleBorder(),
                    fixedSize: const Size.fromRadius(25)),
                onPressed: () {
                  final navigator = Navigator.of(context);
                  navigator.popUntil((route) => !navigator.canPop());
                  MessageBox.showMessage(context,
                      'Images Added To Groups : ${selectedGroup.map((e) => e.name).join(', ')}');
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget groupTile(BuildContext context, GroupData? data) {
    return ListTile(
      onTap: () {
        if (selectedGroup.map((e) => e.id).contains(data.id)) {
          selectedGroup.removeWhere((element) => element.id == data.id);
        } else {
          selectedGroup.add(data);
        }
        setState(() {});
      },
      leading: Hero(
        tag: data!.id,
        child: CircleAvatar(
          foregroundImage:
              (data.imageURL == null) ? null : NetworkImage(data.imageURL!),
          child: const Icon(Icons.group),
        ),
      ),
      title: Text(
        data.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(data.info),
      trailing: (selectedGroup.map((e) => e.id).contains(data.id))
          ? const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            )
          : const Icon(
              Icons.circle_outlined,
              color: Colors.grey,
            ),
    );
  }
}
