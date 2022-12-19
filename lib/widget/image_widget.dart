import 'package:flutter/material.dart';
import 'package:movieapp/app_constants.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String? imageSrc;
  final double height;
  final double width;
  final double radius;

  const ImageNetworkWidget({
    super.key,
    this.imageSrc,
    required this.height,
    required this.width,
    this.radius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        '${AppConstants.imageUrlW500}$imageSrc',
        height: height,
        width: width,
        fit: BoxFit.cover,
        //Disini kita menampilkan error jika data image tersebut tidak dapat di tarik
        errorBuilder: (_, __, ___) {
          return SizedBox(
            child: Icon(Icons.broken_image_outlined),
            height: height,
            width: width,
          );
        },
      ),
    );
  }
}
