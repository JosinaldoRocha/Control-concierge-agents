import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/vacation_details_widget.dart';
import 'package:control_concierge_agents/app/widgets/button/button_widget.dart';
import 'package:flutter/material.dart';
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
        _buildItem('Lotação: ', agent.unit),
        _buildItem('Turno: ', agent.workShift),
        if (agent.phone!.isNotEmpty) _buildItem('Celular: ', '${agent.phone}'),
        if (agent.observations!.isNotEmpty)
          _buildItem(
            'Observações: ',
            agent.observations!,
          ),
        const SpaceVertical.x5(),
        if (agent.bondType == BondTypeEnum.effective &&
            agent.vacation?.vacationExpiration != null)
          ButtonWidget(
            width: 200,
            height: 48,
            title: 'Férias',
            trailing: Icon(
              Icons.flight_takeoff_outlined,
              color: AppColor.white,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: VacationDetailsWidget(agent: agent),
                ),
              );
            },
          ),
        const SpaceVertical.x3(),
      ],
    );
  }

  Column _buildItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SpaceVertical.x1(),
        SelectableText(
          description,
        ),
        const SpaceVertical.x2(),
      ],
    );
  }
}
