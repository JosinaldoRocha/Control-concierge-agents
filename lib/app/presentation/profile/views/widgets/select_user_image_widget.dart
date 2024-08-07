import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../widgets/image/profile_image_widget.dart';

class SelectUserImageWidget extends StatelessWidget {
  const SelectUserImageWidget({
    super.key,
    required this.image,
    required this.onTap,
  });
  final File? image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 104,
        width: 104,
        child: Stack(
          children: [
            ProfileImageWidget(
              image: image?.path,
              size: 100,
            ),
            Positioned(
              top: 74,
              left: 74,
              child: InkWell(
                onTap: onTap,
                child: SvgPicture.asset(
                  'assets/icons/edit.svg',
                  colorFilter: const ColorFilter.mode(
                    AppColor.secondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
