import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          Text(
            agent.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
          const SpaceVertical.x5(),
          _buildItem('Vínculo: ', agent.bondType.text),
          _buildItem('Repartição: ', agent.unit),
          if (agent.vacationMonth != null)
            _buildItem('Mês de férias: ', '${agent.vacationMonth}'),
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
          _buildItem('Celular: ', '${agent.phone}'),
          if (agent.observations != null)
            _buildItem('Obervações: ', '${agent.observations}'),
        ],
      ),
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
            Text(description),
          ],
        ),
        const SpaceVertical.x4(),
      ],
    );
  }
}
