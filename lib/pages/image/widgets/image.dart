import 'package:flutter/material.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart';
import 'package:photo_gallery/photo_gallery.dart' show PhotoProvider;

class ImageBox extends StatefulWidget {
  final TransformationController transformationController;
  final ImageData image;
  final AnimationController animationcontroller;

  const ImageBox(
      {super.key,
      required this.image,
      required this.transformationController,
      required this.animationcontroller});

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _zoomcontroller;
  late Animation<Matrix4> zoomanimation;
  Offset? coordinates;

  @override
  void initState() {
    _zoomcontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        widget.transformationController.value = zoomanimation.value;
      });
    super.initState();
  }

  @override
  void dispose() {
    _zoomcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.animationcontroller.value == 0) {
          widget.animationcontroller.forward();
        } else {
          widget.animationcontroller.reverse();
        }
      },
      onTapDown: (details) => coordinates = details.localPosition,
      onDoubleTap: () {
        final y = -coordinates!.dy * 1.5;
        final x = -coordinates!.dx * 1.5;
        final zoom = Matrix4.identity()
          ..translate(x, y)
          ..scale(2.5);
        final value = (widget.transformationController.value.isIdentity())
            ? zoom
            : Matrix4.identity();
        if (widget.transformationController.value.isIdentity()) {
          widget.animationcontroller.forward();
        } else {
          widget.animationcontroller.reverse();
        }
        zoomanimation = Matrix4Tween(
                begin: widget.transformationController.value, end: value)
            .animate(CurvedAnimation(
                parent: _zoomcontroller, curve: Curves.fastOutSlowIn));
        _zoomcontroller.forward(from: 0);
      },
      // Image to be displayed
      child: Hero(
        tag: 'logo${widget.image.id}',
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
              image: PhotoProvider(mediumId: widget.image.id),
            ),
          ),
        ),
      ),
    );
  }
}
