import 'package:control_concierge_agents/app/presentation/agent/widgets/agent_details_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/agent_model.dart';

class AgentDetailsPage extends StatelessWidget {
  const AgentDetailsPage({
    super.key,
    required this.agent,
  });
  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Agente de portaria',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceVertical.x4(),
          AgentDetailsWidget(agent: agent),
          const SpaceVertical.x5(),
        ],
      ),
    );
  }
}
