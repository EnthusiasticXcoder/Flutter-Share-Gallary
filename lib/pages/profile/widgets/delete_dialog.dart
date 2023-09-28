import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/services/auth/profile/profile_bloc.dart';

class DeleteDialog {
  String? password;
  final _formKey = GlobalKey<FormState>();

  DeleteDialog.showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => build(context),
    ).then(
      (value) => context.read<ProfileBloc>().add(
            const ProfileEventInitial(),
          ),
    );
  }
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete Account',
        style: TextStyle(color: Colors.redAccent),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Enter Your Password To Delete Yor Account.'),
            // margin
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            // confirm new password field
            TextFormField(
              decoration:
                  const InputDecoration(label: Text('Confirm Password')),
              onChanged: (value) => password = value,
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Required Field' : null,
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: <ElevatedButton>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Clear'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<ProfileBloc>().add(
                    ProfileEventDeleteUser(password: password),
                  );

              Navigator.pop(context);
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
