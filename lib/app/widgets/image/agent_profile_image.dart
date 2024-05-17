import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AgentProfileImageWidget extends StatelessWidget {
  const AgentProfileImageWidget({
    super.key,
    required this.image,
    required this.size,
    this.child,
  });

  final String? image;
  final double size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: image == null
          ? Center(
              child: child ??
                  CircleAvatar(
                    radius: size,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
            )
          : image!.contains('agent_images%')
              ? Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(image!),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      strokeAlign: BorderSide.strokeAlignCenter,
                    ),
                  ),
                )
              : Container(
                  width: size,
                  height: size,
                  child: CircleAvatar(
                    radius: size,
                    backgroundImage: FileImage(File(image!)),
                  ),
                ),
    );
  }
}
