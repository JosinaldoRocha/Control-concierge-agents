import 'package:flutter/material.dart';
import '../../../../data/enums/filter_type_enum.dart';
import '../../../../data/models/agent_model.dart';
import '../../../../widgets/spacing/vertical_space_widget.dart';
import 'agent_item_widget.dart';

class AgentListWidget extends StatelessWidget {
  const AgentListWidget({
    super.key,
    required this.agents,
    this.filterType,
    this.filter,
  });

  final List<AgentModel> agents;
  final FilterType? filterType;
  final String? filter;

  @override
  Widget build(BuildContext context) {
    List<AgentModel> filterAgents() {
      if (filter == null || filter!.isEmpty) {
        return agents;
      } else {
        return agents.where((agent) {
          return agent.name == filter! ||
              agent.bondType.text == filter! ||
              agent.unit == filter! ||
              agent.workShift == filter! ||
              agent.vacation?.vacationExpiration?.month.toString() == filter!;
        }).toList();
      }
    }

    final filteredAgents = filterAgents();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      itemBuilder: (context, index) => AgentItemWidget(
        agent: filteredAgents[index],
        filter: filterType,
      ),
      separatorBuilder: (context, index) => const SpaceVertical.x2(),
      itemCount: filteredAgents.length,
    );
  }
}
