import 'package:control_concierge_agents/app/data/providers/data_provider.dart';
import 'package:control_concierge_agents/app/presentation/home/states/agents_list_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/tabs_state_notifier.dart';

final homeTabsProvider = StateNotifierProvider<TabsStateNotifier, int>(
  (ref) => TabsStateNotifier(),
);

final agentListStateProvider =
    StateNotifierProvider<AgentListStateNotifier, AgentListState>(
  (ref) => AgentListStateNotifier(
    dataSource: ref.read(agentDataSourceProvider),
  ),
);
