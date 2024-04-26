import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/agent_details_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/space_horizontal_widget.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildButton(true),
              const SpaceHorizontal.x4(),
              _buildButton(false),
            ],
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildButton(bool isEditButton) {
    final getColor = isEditButton ? AppColor.primary : AppColor.primaryRed;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: AppColor.white,
          side: BorderSide(
            color: getColor,
          )),
      onPressed: () {},
      child: Row(
        children: [
          Text(
            isEditButton ? 'Editar' : 'Excluir',
            style: TextStyle(
              color: getColor,
            ),
          ),
          const SpaceHorizontal.x2(),
          Icon(
            isEditButton ? Icons.edit : Icons.delete,
            color: getColor,
          ),
        ],
      ),
    );
  }
}
