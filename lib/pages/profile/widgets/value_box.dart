import 'package:flutter/material.dart';

class ValueBox extends StatelessWidget {
  const ValueBox({
    super.key,
    required TextEditingController nameController,
    required TextEditingController infoController,
  })  : _nameController = nameController,
        _infoController = infoController;

  final TextEditingController _nameController;
  final TextEditingController _infoController;

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
            ]),
        child: Column(
          children: [
            // Name field
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.blueGrey),
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
            TextField(
              controller: _infoController,
              style: const TextStyle(color: Colors.blueGrey),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.info_outline),
                label: const Text('Info or Status'),
                fillColor: Colors.grey.shade50,
                filled: true,
                hintStyle: const TextStyle(color: Colors.blueGrey),
              ),
            ),
          ],
        ));
  }
}
