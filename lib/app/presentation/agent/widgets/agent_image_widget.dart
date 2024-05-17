import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/style/app_colors.dart';
import '../../../widgets/image/agent_profile_image.dart';

class AgentSelectImageWidget extends StatelessWidget {
  const AgentSelectImageWidget({
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
            AgentProfileImageWidget(
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
