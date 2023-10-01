import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/pages/home/widgets/widgets.dart';
import 'package:gallary/services/auth/auth.dart';
import 'package:gallary/services/cloud/bloc/cloud_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  bool isSideBarOpen = false;

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    context.read<CloudBloc>().add(
          const CloudEventUpdateDatabase(),
        );
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sidebarwidth = MediaQuery.sizeOf(context).width * 0.75;
    return WillPopScope(
      onWillPop: () {
        if (isSideBarOpen) {
          _animationController.reverse();
          isSideBarOpen = !isSideBarOpen;
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: ' ',
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEventLogout());
          },
        ),
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF17203A),
        body: Stack(
          children: [
            // Drawer Widget animation
            AnimatedPositioned(
              width: sidebarwidth,
              height: MediaQuery.of(context).size.height,
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideBarOpen ? 0 : -sidebarwidth,
              top: 0,
              child: const DrawerMenu(),
            ),
            // Tabbar widget animation
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(
                    1 * animation.value - 30 * (animation.value) * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * sidebarwidth * 0.9, 0),
                child: Transform.scale(
                  scale: scalAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(animation.value * 24),
                    ),
                    child: const TabBarWidget(
                      tabs: ['Groups', 'Photos'],
                      tabViews: <Widget>[GroupList(), GallaryImages()],
                    ),
                  ),
                ),
              ),
            ),
            // menu button animation
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideBarOpen ? sidebarwidth * 0.8 : 0,
              top: MediaQuery.sizeOf(context).height * 0.02,
              child: MenuButton(
                onPress: () {
                  if (_animationController.value == 0) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }

                  isSideBarOpen = !isSideBarOpen;
                },
                animation: animation,
              ),
            )
          ],
        ),
      ),
    );
  }
}
