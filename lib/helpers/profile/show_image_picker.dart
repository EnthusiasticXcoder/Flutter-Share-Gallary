import 'package:flutter/material.dart';

Future<void> showImagePicker({
  required BuildContext context,
  required VoidCallback onDeletePic,
  required VoidCallback oncameraPic,
  required VoidCallback onGallaryPic,
}) async {
  await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
          children: <Widget>[
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            //pick profile picture label
            ListTile(
              title: const Text(
                'Pick Profile Picture',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: IconButton(
                  // Function to Remove Profile Pic
                  onPressed: onDeletePic,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black54,
                  )),
            ),

            //for adding some space
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),

            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //pick from gallery button
                imageButton(
                  context: context,
                  text: 'Camera',
                  icon: Icons.camera_alt_rounded,
                  // pic image from camera
                  onPress: oncameraPic,
                ),

                //take picture from camera button
                imageButton(
                  context: context,
                  text: 'Gallery',
                  icon: Icons.image_rounded,
                  // pic image from gallary
                  onPress: onGallaryPic,
                )
              ],
            ),
            //for adding some space
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          ],
        );
      });
}

Widget imageButton({
  required BuildContext context,
  required VoidCallback onPress,
  required IconData icon,
  required String text,
}) {
  return Column(
    children: [
      OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(18.0)),
          onPressed: onPress,
          child: Icon(
            icon,
            size: 40,
          )),
      Text(
        text,
        style: const TextStyle(height: 2.5, color: Colors.black54),
      ),
    ],
  );
}
