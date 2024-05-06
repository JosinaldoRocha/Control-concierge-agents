import 'package:flutter/material.dart';
import '../../../../data/enums/filter_type_enum.dart';
import '../../../../data/models/agent_model.dart';
import '../../../../widgets/spacing/vertical_space_widget.dart';
import 'agent_item_widget.dart';

class AgentListWidget extends StatelessWidget {
  const AgentListWidget({
    super.key,
    required this.agents,
    this.filter,
  });

  final List<AgentModel> agents;
  final FilterType? filter;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) => AgentItemWidget(
        agent: agents[index],
        filter: filter,
      ),
      separatorBuilder: (context, index) => const SpaceVertical.x3(),
      itemCount: agents.length,
    );
  }
}
