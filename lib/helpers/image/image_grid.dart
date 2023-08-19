import 'package:flutter/material.dart';
import 'package:gallary/routs/app_routs.dart';
import 'package:photo_gallery/photo_gallery.dart'
    show Medium, MediumType, ThumbnailProvider;

class ImageGrid extends StatelessWidget {
  final List<Medium> images;
  const ImageGrid({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          Medium image = images.elementAt(index);
          return InkWell(
              onTap: () {
                if (image.mediumType == MediumType.image) {
                  Navigator.of(context).pushNamed(
                    AppRouts.viewImagePage,
                    arguments: {
                      'Image': image,
                      'Index': index,
                    },
                  );
                } else if (image.mediumType == MediumType.video) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(image.mimeType!)));
                  // open video file
                }
              },
              child: Image(
                  loadingBuilder: (context, child, _) => Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(15)),
                        child: child,
                      ),
                  errorBuilder: (context, __, _) => Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                            child: Text('Error! Unable To Load Image')),
                      ),
                  frameBuilder: (context, child, __, _) => Hero(
                        tag: 'logo$index',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: child,
                        ),
                      ),
                  fit: BoxFit.cover,
                  image: ThumbnailProvider(
                      mediumId: image.id, highQuality: true)));
        });
  }
}
