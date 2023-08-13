import 'package:flutter/material.dart';
import 'package:gallary/pages/image/image.dart';
import 'package:photo_gallery/photo_gallery.dart'
    show Medium, ThumbnailProvider;

import 'package:gallary/utils/utils.dart' show getImages;

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImages(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              List images = snapshot.data as List;
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                image: image,
                                index: index,
                              ),
                            ),
                          );
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
                                      child:
                                          Text('Error! Unable To Load Image')),
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
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        });
  }
}
