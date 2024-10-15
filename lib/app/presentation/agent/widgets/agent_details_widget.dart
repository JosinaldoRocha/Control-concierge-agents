import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/widgets/spacing/space_horizontal_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/style/app_text.dart';
import '../../../widgets/spacing/vertical_space_widget.dart';

class AgentDetailsWidget extends StatelessWidget {
  const AgentDetailsWidget({
    super.key,
    required this.agent,
  });

  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DADOS DO AGENTE',
          style: AppText.text().bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.primary,
              ),
        ),
        const SpaceVertical.x3(),
        Container(
          padding: EdgeInsets.all(10).copyWith(bottom: 4),
          decoration: BoxDecoration(
            color: AppColor.bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                agent.name,
                style: AppText.text().titleMedium,
              ),
              Divider(),
              _buildItem('Status: ', agent.status),
              _buildItem('Vínculo: ', agent.bondType.text),
              _buildItem('Lotação: ', agent.unit),
              _buildItem('Turno: ', agent.workShift),
              if (agent.phone!.isNotEmpty)
                _buildItem('Celular: ', '${agent.phone}'),
              if (agent.observations!.isNotEmpty)
                _buildItem(
                  'Observações: ',
                  agent.observations!,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Padding _buildItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          SpaceHorizontal.x1(),
          Expanded(
            child: SelectableText(
              description,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
