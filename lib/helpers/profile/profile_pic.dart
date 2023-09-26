import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/profile/show_image_picker.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart';

class ProfilePicture {
  final String? imagePath;

  ProfilePicture.showDialog(
    BuildContext context,
    this.imagePath,
    IconData child, {
    required VoidCallback onDeletePic,
    required VoidCallback oncameraPic,
    required VoidCallback onGallaryPic,
  }) {
    showDialog(
      context: context,
      builder: (_) =>
          build(context, child, oncameraPic, onGallaryPic, onDeletePic),
    );
  }

  ProfilePicture.showImageView(
      BuildContext context, this.imagePath, IconData child) {
    showDialog(
      context: context,
      builder: (_) => imagebuild(context, child),
    ).then((_) => context.read<CloudBloc>().add(
          const CloudEventInitial(),
        ));
  }

  Widget imagebuild(BuildContext context, IconData child) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            decoration: BoxDecoration(
              color: (imagePath == null) ? Colors.white70 : Colors.black54,
              borderRadius: BorderRadius.circular(24),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.34,
              width: double.maxFinite,
              child: (imagePath == null)
                  ? Icon(
                      child,
                      size: MediaQuery.sizeOf(context).width * 0.6,
                    )
                  : Image.network(
                      imagePath!,
                      fit: BoxFit.scaleDown,
                      errorBuilder: (context, error, stackTrace) =>
                          const Text('Unable To Load Image'),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(
    BuildContext context,
    IconData child,
    VoidCallback oncameraPic,
    VoidCallback onGallaryPic,
    VoidCallback onDeletePic,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(24)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.34,
                      width: double.maxFinite,
                      child: (imagePath == null)
                          ? Icon(
                              child,
                              color: Colors.white,
                              size: MediaQuery.sizeOf(context).width * 0.6,
                            )
                          : Image.network(
                              imagePath!,
                              fit: BoxFit.scaleDown,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text('Unable To Load Image'),
                            ),
                    ),
                    // Edit Button
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.06,
                      color: Colors.white,
                      child: TextButton.icon(
                          // edit profile pic
                          onPressed: () async {
                            Navigator.pop(context);
                            // show image picker bottom dialog sheet
                            await showImagePicker(
                              context: context,
                              onDeletePic: onDeletePic,
                              oncameraPic: oncameraPic,
                              onGallaryPic: onGallaryPic,
                            );
                          },
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
