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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
            ),
          ),
          const SpaceHorizontal.x2(),
          const Icon(Icons.person_3_outlined),
        ],
      ),
    );
  }
}
