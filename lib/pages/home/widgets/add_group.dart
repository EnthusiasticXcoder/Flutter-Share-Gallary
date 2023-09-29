import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/services/cloud/bloc/cloud_bloc.dart';

class AddGroupBottomSheet {
  String? _groupId;

  String? _groupName;
  String? _groupInfo;

  final _joinformkey = GlobalKey<FormState>();
  final _createformkey = GlobalKey<FormState>();

  AddGroupBottomSheet.showAddBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) => addGroupbuild(context),
    );
    context.read<CloudBloc>().add(
          const CloudEventInitial(),
        );
  }

  AddGroupBottomSheet.showAddedBottomSheet(BuildContext context, String? id) {
    showBottomSheet(
      context: context,
      builder: (context) => groupAddedbuild(context, id),
    );

    context.read<CloudBloc>().add(
          const CloudEventInitial(),
        );
  }

  Widget groupAddedbuild(BuildContext context, String? id) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // margin
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
          const Text(
            'GroupId',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),

          // margin
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
          TextFormField(
            initialValue: id,
            readOnly: true,
          ),

          // margin
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
        ],
      ),
    );
  }

  Widget addGroupbuild(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.75,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            // margin
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
            // join group label text
            const Text(
              'Join Group',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            // margin
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
            // group Id text field
            Form(
              key: _joinformkey,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text('Group Id'),
                ),
                onChanged: (value) => _groupId = value,
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Required Field' : null,
              ),
            ),
            // margin
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            // join group button
            ElevatedButton(
              onPressed: () {
                if (_joinformkey.currentState!.validate()) {
                  context.read<CloudBloc>().add(
                        CloudEventAddAGroup(groupId: _groupId),
                      );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade300,
                foregroundColor: Colors.black,
              ),
              child: const Text('Join Group'),
            ),
            // devider
            const Divider(height: 50),
            // group create label
            const Text(
              'Create New Group',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            // margin
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
            // create group form
            Form(
              key: _createformkey,
              child: Column(
                children: <Widget>[
                  // group name text field
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Group Name'),
                    ),
                    onChanged: (value) => _groupName = value,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Required Field'
                        : null,
                  ),
                  // margin
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                  // Group info text field
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Group Info'),
                    ),
                    onChanged: (value) => _groupInfo = value,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Required Field'
                        : null,
                  ),
                ],
              ),
            ),

            // margin
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            // create group button
            ElevatedButton(
              onPressed: () {
                if (_createformkey.currentState!.validate()) {
                  context.read<CloudBloc>().add(
                        CloudEventAddAGroup(
                          groupName: _groupName,
                          groupInfo: _groupInfo,
                        ),
                      );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade300,
                foregroundColor: Colors.black,
              ),
              child: const Text('Create Group'),
            ),
          ],
        ),
      ),
    );
  }
}
