import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(
    BuildContext context,
    String title,
    Color bgColor,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        content: Text(
          title,
          style: const TextStyle(color: AppColor.white),
        ),
      ),
    );
  }
}
