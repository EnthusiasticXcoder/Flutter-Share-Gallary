import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart' show Medium;

import '../widgets/widgets.dart';

class DetailsPage extends StatefulWidget {
  final Medium image;
  final int index;

  const DetailsPage({super.key, required this.image, required this.index});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  late TransformationController _transformationController;

  @override
  void initState() {
    _transformationController = TransformationController();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(
        () {
          setState(() {});
        },
      );
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: Transform.translate(
          offset: Offset(0, -100 * animation.value),
          child: AppBar(
            toolbarHeight: 60,
            iconTheme: const IconThemeData(size: 30, color: Colors.white),
            backgroundColor: Colors.black.withOpacity(0.7),
          ),
        ),
        preferredSize: const Size(0, 60),
      ),
      body: InteractiveViewer(
        transformationController: _transformationController,
        onInteractionStart: (_) {
          _animationController.forward();
        },
        child: ImageBox(
          image: widget.image,
          index: widget.index,
          transformationController: _transformationController,
          animationcontroller: _animationController,
        ),
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 260 * animation.value),
        child: const DetailsBox(),
      ),
    );
  }
}
