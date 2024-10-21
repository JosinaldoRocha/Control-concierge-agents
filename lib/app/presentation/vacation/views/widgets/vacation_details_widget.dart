import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/widgets/button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../data/enums/vacation_status_enum.dart';
import '../../../../widgets/spacing/spacing.dart';

class VacationDetailsWidget extends StatelessWidget {
  const VacationDetailsWidget({
    super.key,
    required this.agent,
  });
  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10).copyWith(bottom: 4),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Férias',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: VacationStatus.status(agent.vacation!).color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    VacationStatus.status(agent.vacation!).text,
                    style: const TextStyle(
                      color: AppColor.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SpaceVertical.x4(),
          if (agent.vacation?.vacationExpiration != null)
            _buildItem(
              'Vencimento:',
              DateFormat('dd/MM/yyyy')
                  .format(agent.vacation!.vacationExpiration!),
            ),
          if (agent.vacation?.vacationMonth != null &&
              agent.vacation!.vacationMonth!.isNotEmpty)
            _buildItem('Mês base:', '${agent.vacation!.vacationMonth}'),
          if (agent.vacation?.startVacation != null)
            _buildItem(
              'Início:',
              DateFormat('dd/MM/yyyy').format(agent.vacation!.startVacation!),
            ),
          if (agent.vacation?.endVacation != null)
            _buildItem(
              'Término:',
              DateFormat('dd/MM/yyyy').format(agent.vacation!.endVacation!),
            ),
          if (agent.vacation?.vestingPeriod != null &&
              agent.vacation!.vestingPeriod!.isNotEmpty)
            _buildItem(
                'Período aquisitivo', '${agent.vacation!.vestingPeriod}'),
          SpaceVertical.x2(),
          Align(
            alignment: Alignment.centerRight,
            child: ButtonWidget(
              height: 40,
              width: 150,
              title: 'Histórico de férias',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/vacation/history',
                  arguments: agent,
                );
              },
            ),
          ),
        ],
      ),
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
