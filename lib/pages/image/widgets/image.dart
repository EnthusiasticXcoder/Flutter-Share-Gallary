import 'package:flutter/material.dart';

class ImageBox extends StatefulWidget {
  final TransformationController transformationController;
  final String imagePath;
  final int index;
  final AnimationController animationcontroller;

  const ImageBox(
      {super.key,
      required this.imagePath,
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
      onTapCancel: () => Navigator.of(context).pop(),
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
      child: SizedBox(
        height: double.infinity,
        width: double.maxFinite,
        child: Image.network(
          widget.imagePath,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) => Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(15)),
            child: child,
          ),
          errorBuilder: (context, error, stackTrace) => Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(15)),
            child: const Center(child: Text('Error! Unable To Load Image')),
          ),
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => Hero(
            tag: 'logo${widget.index}',
            child: child,
          ),
        ),
      ),
    );
  }
}
