import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/image/image_grid.dart';
import 'package:gallary/services/cloud/bloc/cloud_bloc.dart';

class GallaryImages extends StatelessWidget {
  const GallaryImages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CloudBloc, CloudState>(
      buildWhen: (previous, current) => current is CloudStateImageGrid,
      builder: (context, state) {
        state = state as CloudStateImageGrid;
        return ImageGrid(images: state.images);
      },
    );
  }
}
