import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/services/auth/auth_user.dart';
import 'package:gallary/services/auth/profile/profile_bloc.dart';

class ValueBox extends StatefulWidget {
  const ValueBox({
    super.key,
    this.user,
  });
  final AuthUser? user;

  @override
  State<ValueBox> createState() => _ValueBoxState();
}

class _ValueBoxState extends State<ValueBox> {
  late final TextEditingController _nameController;
  late final TextEditingController _infoController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.user?.name);
    _infoController = TextEditingController(text: widget.user?.info);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.02),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color.fromARGB(255, 240, 248, 251),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            spreadRadius: -1.0,
            blurRadius: 10.0,
            offset: Offset(5.0, 5.0),
          ),
          BoxShadow(
            color: Colors.black12,
            spreadRadius: -1.0,
            blurRadius: 10.0,
            offset: Offset(-3.0, -3.0),
          ),
        ],
      ),
      child: Form(
        key: _formkey,
        onWillPop: () {
          final info = _infoController.text;
          final name = _nameController.text;
          if (_formkey.currentState!.validate() &&
              (info != widget.user?.info || name != widget.user?.name)) {
            context.read<ProfileBloc>().add(
                  ProfileEventUpdateUser(info: info, name: name),
                );
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Column(
          children: [
            // Name field
            TextFormField(
              controller: _nameController,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              style: const TextStyle(color: Colors.blueGrey),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Required Field' : null,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                label: const Text('Name'),
                fillColor: Colors.grey.shade50,
                filled: true,
                hintStyle: const TextStyle(color: Colors.blueGrey),
              ),
            ),

            // margin
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            // Info or status field
            TextFormField(
              controller: _infoController,
              style: const TextStyle(color: Colors.blueGrey),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Required Field' : null,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.info_outline),
                label: const Text('Info or Status'),
                fillColor: Colors.grey.shade50,
                filled: true,
                hintStyle: const TextStyle(color: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
