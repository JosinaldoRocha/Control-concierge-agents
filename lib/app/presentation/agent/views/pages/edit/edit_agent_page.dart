import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/presentation/agent/views/component/add_edit_agent_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditAgentPage extends ConsumerStatefulWidget {
  const EditAgentPage({super.key, this.agent});
  final AgentModel? agent;

  @override
  ConsumerState<EditAgentPage> createState() => _AddAgentPageState();
}

class _AddAgentPageState extends ConsumerState<EditAgentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddEditAgentComponent(agent: widget.agent),
    );
  }
}
