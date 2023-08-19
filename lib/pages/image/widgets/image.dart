import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart' show Medium, PhotoProvider;

class ImageBox extends StatefulWidget {
  final TransformationController transformationController;
  final Medium image;
  final int index;
  final AnimationController animationcontroller;

  const ImageBox(
      {super.key,
      required this.image,
      required this.index,
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
      child: SizedBox(
          height: double.infinity,
          width: double.maxFinite,
          child: Image(
              loadingBuilder: (context, child, loading) => Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(15)),
                    child: child,
                  ),
              errorBuilder: (context, __, _) => Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                        child: Text('Error! Unable To Load Image')),
                  ),
              frameBuilder: (context, child, __, _) => Hero(
                    tag: 'logo${widget.index}',
                    child: child,
                  ),
              image: PhotoProvider(mediumId: widget.image.id))),
    );
  }
}
