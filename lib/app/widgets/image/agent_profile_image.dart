import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

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
          : Container(
              width: size,
              height: size,
              child: image!.contains('agent_images')
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: image!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => LoadingIndicator(
                          indicatorType: Indicator.circleStrokeSpin,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: size,
                      backgroundImage: FileImage(File(image!)),
                    ),
            ),
    );
  }
}
