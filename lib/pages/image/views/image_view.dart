import 'package:flutter/material.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart';

import '../widgets/widgets.dart';

class DetailsPage extends StatefulWidget {
  final ImageData image;

  const DetailsPage({super.key, required this.image});

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
      appBar: AnimatedAppbar(
        animation: animation,
        title: widget.image.title,
      ),
      body: InteractiveViewer(
        transformationController: _transformationController,
        onInteractionStart: (_) {
          _animationController.forward();
        },
        child: ImageBox(
          image: widget.image,
          transformationController: _transformationController,
          animationcontroller: _animationController,
        ),
      ),
      bottomNavigationBar: DetailsBox(
        animation: animation,
        image: widget.image,
      ),
    );
  }
}

class AnimatedAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AnimatedAppbar({
    super.key,
    required this.animation,
    required this.title,
  });

  final String? title;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -100 * animation.value),
      child: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: Text(title ?? ''),
        iconTheme: const IconThemeData(size: 30, color: Colors.white),
        backgroundColor: Colors.black.withOpacity(0.7),
        foregroundColor: Colors.white,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(0, 60);
}
