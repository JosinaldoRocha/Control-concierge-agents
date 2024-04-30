import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/widgets/spacing/space_horizontal_widget.dart';
import 'package:flutter/material.dart';

class AgentItemWidget extends StatelessWidget {
  const AgentItemWidget({
    super.key,
    required this.agent,
  });
  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    String getInitials(String name) {
      List<String> nameParts = name.split(' ');
      String initials = '';

      int count = 0;

      for (String part in nameParts) {
        if (part.isNotEmpty && part[0].toUpperCase() == part[0]) {
          initials += part[0];
          count++;
        }

        if (count == 2) break;
      }

      return initials;
    }

    String agentInitials = getInitials(agent.name);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColor.primary),
        ),
        backgroundColor: AppColor.white,
      ),
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/agent/details',
          arguments: agent,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              agent.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColor.primary),
            ),
          ),
          const SpaceHorizontal.x2(),
          Text(
            agentInitials,
            style: const TextStyle(
                fontSize: 18,
                color: AppColor.primary,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
