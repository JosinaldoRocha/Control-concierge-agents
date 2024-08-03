import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../core/style/app_colors.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
    required this.image,
    required this.size,
  });

  final String? image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: image != null && image!.isNotEmpty
            ? Border.all(
                width: 1.5,
                color: AppColor.primary,
              )
            : null,
      ),
      child: image == null || image!.isEmpty
          ? Center(
              child: CircleAvatar(
                radius: size,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            )
          : Container(
              width: size,
              height: size,
              child: image!.contains('control-concierge-agents')
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
