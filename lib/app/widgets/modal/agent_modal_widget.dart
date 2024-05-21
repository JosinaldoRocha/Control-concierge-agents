import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/core/style/app_text.dart';
import 'package:flutter/material.dart';
import '../button/button_widget.dart';
import '../spacing/spacing.dart';

class AgentModalWidget extends StatelessWidget {
  const AgentModalWidget({
    super.key,
    required this.title,
    required this.description,
    required this.confirmTitle,
    this.cancelTitle,
    required this.onConfirm,
    this.onCancel,
    this.titleColor,
  });
  final String title;
  final String description;
  final String confirmTitle;
  final String? cancelTitle;
  final Function() onConfirm;
  final Function()? onCancel;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.only(
        top: 8,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      child: Column(
        children: [
          Container(
            height: 3,
            width: 38,
            decoration: BoxDecoration(
              color: AppColor.lightGrey2,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SpaceVertical.x8(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppText.text().titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? AppColor.primary,
                ),
          ),
          const SpaceVertical.x6(),
          const Divider(
            height: 0,
            color: AppColor.lightGrey2,
          ),
          const SpaceVertical.x6(),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
          const SpaceVertical.x6(),
          Row(
            children: [
              if (cancelTitle != null)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ButtonWidget(
                      title: cancelTitle ?? '',
                      onTap: onCancel,
                      color: AppColor.lightGrey2,
                      textColor: AppColor.primaryRed,
                    ),
                  ),
                ),
              Expanded(
                child: ButtonWidget(
                  title: confirmTitle,
                  onTap: onConfirm,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
