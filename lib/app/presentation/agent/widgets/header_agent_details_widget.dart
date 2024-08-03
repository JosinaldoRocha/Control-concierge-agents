import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/widgets/image/profile_image_widget.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          ProfileImageWidget(
            image: agent.imageUrl,
            size: 80,
          ),
          const SpaceHorizontal.x4(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agent.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SpaceVertical.x2(),
                Container(
                  width: 118,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: agent.bondType == BondTypeEnum.effective
                        ? AppColor.primaryGreen
                        : AppColor.primary,
                    borderRadius: BorderRadius.circular(10),
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
            ),
          ),
        ],
      ),
    );
  }
}
