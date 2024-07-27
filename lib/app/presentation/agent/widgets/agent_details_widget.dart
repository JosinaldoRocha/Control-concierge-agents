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
          if (agent.vacation?.vacationExpiration != null)
            _buildVacationDetails(),
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
          padding: EdgeInsets.all(8).copyWith(bottom: 0),
          decoration: BoxDecoration(
            color: AppColor.lightBlue,
            borderRadius: BorderRadius.circular(12),
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
              if (agent.vacation?.vacationExpiration != null)
                _buildItem(
                  'Vencimento das férias: ',
                  DateFormat('dd/MM/yyyy')
                      .format(agent.vacation!.vacationExpiration!),
                ),
              if (agent.vacation?.vacationMonth != null &&
                  agent.vacation!.vacationMonth!.isNotEmpty)
                _buildItem('Mês base para férias: ',
                    '${agent.vacation!.vacationMonth}'),
              if (agent.vacation?.startVacation != null)
                _buildItem(
                  'Início das férias: ',
                  DateFormat('dd/MM/yyyy')
                      .format(agent.vacation!.startVacation!),
                ),
              if (agent.vacation?.endVacation != null)
                _buildItem(
                  'Término das férias: ',
                  DateFormat('dd/MM/yyyy').format(agent.vacation!.endVacation!),
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
