import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/image/image_grid.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

class SelectionGrid extends ImageGrid {
  final ImageData? selectedImage;
  final VoidCallback? onselect;
  const SelectionGrid({
    super.key,
    required super.images,
    this.selectedImage,
    this.onselect,
  });

  @override
  Widget build(BuildContext context) {
    context.read<CloudBloc>().add(
          CloudEventShareImage(image: selectedImage, clear: true),
        );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: BlocBuilder<CloudBloc, CloudState>(
          builder: (context, state) {
            if (state is CloudStateShareImages) {
              return Text('(${state.selectedImages.length}) Select Images');
            } else {
              return const Text('(0) Select Images');
            }
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onselect,
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              'Select',
              style: TextStyle(fontSize: 17.0),
            ),
          ),
    
          // margin
          const SizedBox(width: 20.0),
        ],
      ),
      body: GridView(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: images
            .map(
              (image) => InkWell(
                onTap: () {
                  context.read<CloudBloc>().add(
                        CloudEventShareImage(image: image),
                      );
                },
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (image.imageURL != null)
                            ? NetworkImage(image.imageURL!) as ImageProvider
                            : ThumbnailProvider(mediumId: image.id),
                      ),
                      border: Border.all(
                        color:
                            (image.isSync) ? Colors.green : Colors.redAccent,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.topRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        // video duration
                        (image.mediumType == MediumType.video)
                            ? videoDurationWidget(image)
                            : Container(),
                        // selected mark
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<CloudBloc, CloudState>(
                            builder: (context, state) {
                              if (state is CloudStateShareImages) {
                                if (state.selectedImages.contains(image)) {
                                  return const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  );
                                }
                              }
                              return const Icon(
                                Icons.circle_outlined,
                                color: Colors.grey,
                              );
                            },
                          ),
                        )
                      ],
                    )),
              ),
            )
            .toList(),
      ),
    );
  }
}
