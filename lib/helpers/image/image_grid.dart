import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallary/helpers/message_box.dart';
import 'package:gallary/routs/app_routs.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart';
import 'package:photo_gallery/photo_gallery.dart'
    show MediumType, ThumbnailProvider;

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key, required this.images, this.showBorder = true});

  final Iterable<ImageData> images;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: images
          .map(
            (image) => InkWell(
              onLongPress: () {
                Navigator.of(context).pushNamed(
                  AppRouts.selectionView,
                  arguments: {
                    'Images': images,
                    'Image': image,
                    'onSelect': () {
                      Navigator.of(context).pushNamed(
                        AppRouts.groupSelect,
                      );
                    }
                  },
                );
              },
              onTap: () {
                if (image.mediumType == MediumType.image) {
                  image.tag = 'logo${image.id}';
                  Navigator.of(context).pushNamed(
                    AppRouts.viewImagePage,
                    arguments: image,
                  );
                } else if (image.mediumType == MediumType.video) {
                  MessageBox.showMessage(context, image.mimeType ?? '');
                  // open video file
                }
              },
              child: Hero(
                tag: 'logo${image.id}',
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (image.imageURL != null)
                          ? NetworkImage(image.imageURL!)
                          : (image.id.isEmpty && image.path != null)
                              ? FileImage(File(image.path!)) as ImageProvider
                              : ThumbnailProvider(mediumId: image.id),
                    ),
                    border: (showBorder)
                        ? Border.all(
                            color: (image.isSync)
                                ? Colors.green
                                : Colors.redAccent,
                            width: 1.5)
                        : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.topRight,
                  child: (image.mediumType == MediumType.video)
                      ? videoDurationWidget(image)
                      : Container(),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Container videoDurationWidget(ImageData image) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.play_circle,
            color: Colors.white,
          ),
          Text(
            durationconvert(image.duration),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  String durationconvert(int miliseconds) {
    final time = Duration(milliseconds: miliseconds);
    if (time.inDays != 0) {
      return '${time.inDays}:${time.inHours % 24 * 3600}:${time.inMinutes % 3600}:${time.inSeconds % 60}';
    } else if (time.inHours != 0) {
      return '${time.inHours % 24 * 3600}:${time.inMinutes % 3600}:${time.inSeconds % 60}';
    } else {
      return '${time.inMinutes}:${time.inSeconds % 60}';
    }
  }
}
