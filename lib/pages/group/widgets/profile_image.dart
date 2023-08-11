import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String? imagePath;
  const ProfilePicture({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: 350,
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(24)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    // Image
                    Center(
                      child: (imagePath == null)
                          ? const Text(
                              'No Profile Image Found\nUpload A Image',
                              textAlign: TextAlign.center,
                            )
                          : Image.network(
                              imagePath!,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text('Unable To Load Image'),
                            ),
                    ),
                    // Edit Button
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit')),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
