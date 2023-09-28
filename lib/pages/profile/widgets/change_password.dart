import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/services/auth/profile/profile_bloc.dart';

class ChangePassword {
  String? oldpassword = '';
  String? newpassword = '';
  String? confirmpassword = '';

  final _formkey = GlobalKey<FormState>();

  ChangePassword.showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => build(context),
    );
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Change Password',
        style: TextStyle(color: Colors.green),
      ),
      content: Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // old password field
            TextFormField(
              decoration: const InputDecoration(label: Text('Old Password')),
              onChanged: (value) => oldpassword = value,
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Required Field' : null,
            ),
            // margin
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
            // new password field
            TextFormField(
              decoration: const InputDecoration(label: Text('New Password')),
              onChanged: (value) => newpassword = value,
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Required Field' : null,
            ),

            // margin
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
            // confirm new password field
            TextFormField(
              decoration:
                  const InputDecoration(label: Text('Confirm Password')),
              onChanged: (value) => confirmpassword = value,
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Required Field' : null,
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: <Widget>[
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
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            if (_formkey.currentState!.validate() &&
                newpassword == confirmpassword) {
              context.read<ProfileBloc>().add(
                    ProfileEventChangePassword(
                      oldpassword: oldpassword,
                      password: newpassword,
                    ),
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
