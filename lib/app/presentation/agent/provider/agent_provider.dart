import 'package:control_concierge_agents/app/data/providers/data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/add_agent_state_notifier.dart';

final addAgentStateProvider =
    StateNotifierProvider<AddAgentStateNotifier, AddAgentState>(
  (ref) => AddAgentStateNotifier(
    dataSource: ref.read(agentDataSourceProvider),
  ),
);
