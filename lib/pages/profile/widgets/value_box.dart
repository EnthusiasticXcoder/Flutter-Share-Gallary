import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/services/auth/auth_user.dart';
import 'package:gallary/services/auth/profile/profile_bloc.dart';

class ValueBox extends StatefulWidget {
  const ValueBox({super.key, this.user});
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
          vertical: MediaQuery.of(context).size.height * 0.02),
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
        canPop: false,
        onPopInvoked: (didpop) {
          if (didpop) return;
          final info = _infoController.text;
          final name = _nameController.text;
          if (_formkey.currentState!.validate() &&
              (info != widget.user?.info || name != widget.user?.name)) {
            context.read<ProfileBloc>().add(
                  ProfileEventUpdateUser(info: info, name: name),
                );
          } else {
            context.read<ProfileBloc>().add(const ProfileEventExit());
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Name field
            textInputField(context, Icons.person, 'Name', _nameController),
            // Info or status field
            textInputField(
                context, Icons.info_outline, 'Info or Status', _infoController),
          ],
        ),
      ),
    );
  }

  Widget textInputField(BuildContext context, IconData icon, String label,
      TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: TextFormField(
        controller: controller,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        style: const TextStyle(color: Colors.blueGrey),
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Required Field' : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          label: Text(label),
          fillColor: Colors.grey.shade50,
          filled: true,
          hintStyle: const TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }
}
