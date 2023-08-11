import 'package:flutter/material.dart';


class MenuButton extends StatelessWidget {
  final VoidCallback onPress;
  final Animation<double> animation;

  const MenuButton({super.key, required this.onPress, required this.animation});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: onPress,
        child: Container(
          margin: const EdgeInsets.only(left: 12),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: animation,
            ),
          ),
        ),
      ),
    );
  }
}
