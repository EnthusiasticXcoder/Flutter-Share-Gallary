import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/image/image_grid.dart';
import 'package:gallary/services/cloud/bloc/cloud_bloc.dart';

class GallaryImages extends StatelessWidget {
  const GallaryImages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<ImageData>>(
      stream: context.select((CloudBloc bloc) => bloc.allImages),
      builder: (context, snapshort) {
        if (snapshort.hasData) {
          return ImageGrid(images: snapshort.data!);
        } else {
          return Container();
        }
      },
    );
  }
}
