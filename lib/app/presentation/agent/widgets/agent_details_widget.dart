import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/widgets/spacing/space_horizontal_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../widgets/spacing/vertical_space_widget.dart';
import 'header_agent_details_widget.dart';

class AgentDetailsWidget extends StatelessWidget {
  const AgentDetailsWidget({
    super.key,
    required this.agent,
  });

  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.primary),
      ),
      child: Column(
        children: [
          HeaderAgentDetailsWidget(agent: agent),
          const Divider(height: 32),
          _buildItem('Lotação: ', agent.unit),
          _buildItem('Turno: ', agent.workShift),
          if (agent.vacationPay != null) _buildVacationDetails(),
          if (agent.phone!.isNotEmpty)
            _buildItem('Celular: ', '${agent.phone}'),
          if (agent.observations!.isNotEmpty)
            _buildItem(
              'Observações: ',
              agent.observations!,
            ),
          const Divider(height: 10),
        ],
      ),
    );
  }

  Column _buildVacationDetails() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColor.lightBlue,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 0.7,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Férias',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SpaceVertical.x2(),
              _buildItem(
                'Vencimento das férias: ',
                DateFormat('dd/MM/yyyy').format(agent.vacationPay!),
              ),
              if (agent.vacationMonth != null)
                _buildItem('Mês base para férias: ', '${agent.vacationMonth}'),
              if (agent.startVacation != null)
                _buildItem(
                  'Início das férias: ',
                  DateFormat('dd/MM/yyyy').format(agent.startVacation!),
                ),
              if (agent.endVacation != null)
                _buildItem(
                  'Término das férias: ',
                  DateFormat('dd/MM/yyyy').format(agent.endVacation!),
                ),
            ],
          ),
        ),
        const SpaceVertical.x2(),
      ],
    );
  }

  Column _buildItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SpaceHorizontal.x4(),
            Expanded(
              child: SelectableText(
                description,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SpaceVertical.x2(),
      ],
    );
  }
}
