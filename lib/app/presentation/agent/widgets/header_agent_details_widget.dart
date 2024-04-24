import 'package:flutter/material.dart';
import '../../../core/style/app_colors.dart';
import '../../../data/models/agent_model.dart';
import '../../../widgets/spacing/spacing.dart';

class HeaderAgentDetailsWidget extends StatelessWidget {
  const HeaderAgentDetailsWidget({
    super.key,
    required this.agent,
  });

  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            agent.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        const SpaceHorizontal.x1(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              agent.bondType.text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
