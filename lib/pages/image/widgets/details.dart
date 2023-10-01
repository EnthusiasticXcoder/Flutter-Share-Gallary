import 'package:flutter/material.dart';
import 'package:gallary/services/cloud/bloc/bloc.dart' show ImageData;

class DetailsBox extends StatelessWidget {
  final Animation<double> animation;
  final ImageData image;
  const DetailsBox({super.key, required this.animation, required this.image});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, 220 * animation.value),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 20),
                blurRadius: 20,
              ),
            ],
          ),
          child: Text(
            'Title : ${image.filename}\nDimentions : ${image.width}x${image.height}\nSize : ${((image.size ?? 0) / (1024 * 1024)).toStringAsFixed(2)}MB\nAlbum Name : ${image.albumName}\nCreation Date : ${image.creationDate}\nModification Date : ${image.modifiedDate}\nisSync : ${image.isSync}\n',
            style: const TextStyle(color: Colors.white, fontSize: 15.5),
          ),
        ),
      ),
    );
  }
}
